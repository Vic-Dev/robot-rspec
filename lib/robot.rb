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
    if @health - amount < 0
      @health = 0
    else
      @health -= amount
    end
  end

  def heal(amount)
    if @health + amount > 100
      @health = 100
    else
      @health += amount
    end
  end

  def attack(enemy)
    if equipped_weapon.nil?
      enemy.wound(@hitpoints)
    else
      equipped_weapon.hit(enemy)
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





