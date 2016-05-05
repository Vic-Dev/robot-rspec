require 'pry'

require_relative 'robot'
require_relative 'item'
require_relative 'weapon'
require_relative 'box_of_bolts'
require_relative 'laser'
require_relative 'plasma_cannon'

class Robot

  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end

  MAX_WEIGHT = 250

  attr_reader :position, :items, :health, :hitpoints
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @hitpoints = 5
    @equipped_weapon = nil
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
    if item.is_a? Weapon
      @equipped_weapon = item
    elsif item.is_a? BoxOfBolts
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
    @health -= amount
    @health = 0 if @health < 0
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

end





