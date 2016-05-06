require 'pry'

require_relative 'robot'
require_relative 'item'
require_relative 'weapon'
require_relative 'box_of_bolts'
require_relative 'laser'
require_relative 'plasma_cannon'
require_relative 'battery'

class Robot

  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end

  MAX_WEIGHT = 250

  @@list = []

  attr_reader :position, :items, :hitpoints, :name
  attr_accessor :equipped_weapon, :health, :shield_points

  def initialize(name)
    @name = name
    @position = [0,0]
    @items = []
    @health = 100
    @hitpoints = 5
    @equipped_weapon = nil
    @shield_points = 50
    @@list << self
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    return if item.weight + items_weight > MAX_WEIGHT
    @equipped_weapon = item if item.is_a? Weapon
    if item.is_a? BoxOfBolts
      item.feed(self) unless health > 80
    end
    @items << item
  end

  def items_weight
    weight = 0
    if @items.empty?
      weight
    else
      @items.each do |item|
        weight += item.weight
      end
      weight
    end
    # .inject
  end

  def wound(amount)
    if amount > @shield_points
      amount -= @shield_points
      @shield_points = 0
      @health -= amount
      @health = 0 if @health < 0
    elsif amount <= @shield_points
      @shield_points -= amount
    end
  end

  def recharge
    battery = items.detect {|x| x.is_a? Battery} 
    if battery
      @items.delete(battery)
      @shield_points += 25
    end
  end

  def heal(amount)
    @health += amount
    @health = 100 if @health > 100
  end

  def position_compare_x(enemy)
    x = (enemy.position[0] - @position[0]).abs
  end

  def position_compare_y(enemy)
    y = (enemy.position[1] - @position[1]).abs
  end

  def attack(enemy)
    x = position_compare_x(enemy)
    y = position_compare_y(enemy)
    if x <= 1 && y <= 1
      if equipped_weapon.nil?
        enemy.wound(@hitpoints)
      else
        equipped_weapon.hit(enemy)
      end
    elsif (x <= 2) && (y <= 2) && (equipped_weapon.is_a? Grenade)
      equipped_weapon.hit(enemy)
      @equipped_weapon = nil
    end
  end

  def heal!(amount)
    if @health <= 0
      raise RobotAlreadyDeadError, "Health too low!"
    else
      heal(amount)
    end
  end

  def attack!(enemy)
    if enemy.is_a? Robot
      attack(enemy)
    else
      raise UnattackableEnemy, "Can only attack a robot!"
    end
  end

  def self.all_in_position(x, y)
    @@list.select do |robot| 
      if robot.position[0] == x && robot.position[1] == y
        robot
      end
    end
  end

  def scanner
    array = []
    range_x = (position[0]-1..position[0]+1)
    range_y = (position[1]-1..position[1]+1)
    range_x.each do |x|
      range_y.each do |y|
        # Another way to remove self from array returned by scanner
        # if position[0] == x && position[1] == y
        #   break
        # end
        robots = self.class.all_in_position(x, y)
        array.concat robots unless robots.nil? || robots.empty?
      end
    end
    # Remove self from array returned by scanner
    array.delete_if {|robot| robot == self}
    array
  end

end





