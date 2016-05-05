# Batteries are items that can be used by robot to recharge its shield. Implement Battery item that can be used to recharge the Robot’s shield. Batteries have a weight of 25.

require 'spec_helper'

describe Battery do
  before :each do
    @battery = Battery.new
    @robot = Robot.new
  end

  it "should be an item" do
    expect(@battery).to be_a(Item)
  end

  it "should be called 'Battery'" do
    expect(@battery.name).to eq('Battery')
  end

  it "should have a weight of 25" do
    expect(@battery.weight).to eq(25)
  end
end

describe Robot do
  before :each do
    @battery = Battery.new
    @robot = Robot.new
  end

  describe '#recharge' do

    it "robot should use battery to recharge its shield" do
      initial_shield_points = @robot.shield_points
      @robot.pick_up(@battery)
      @robot.recharge
      expect(@robot.shield_points).to eq(initial_shield_points + 25)
    end
  end
end
