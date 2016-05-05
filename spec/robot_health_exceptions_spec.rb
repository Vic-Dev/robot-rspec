require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @item = Item.new('thing', 30)
  end

  describe '#heal!' do

    it "should return an error string if health is 0 or less" do
      @robot.wound(100)
      expect{@robot.heal!(10)}.to raise_error(Robot::RobotAlreadyDeadError)
    end

  end

  describe '#attack!' do

    it "should return an error string if target being attacked is not a robot" do
      expect{@robot.attack!(@item)}.to raise_error(Robot::UnattackableEnemy)
    end

  end



end