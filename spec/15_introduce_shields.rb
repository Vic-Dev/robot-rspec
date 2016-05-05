# Robots can start with 50 shield points. When the robot is damaged it first drains the shield and then starts affecting actual health.

require 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe '#shield_points' do

    it "should start off with 50 shield points" do
      expect(@robot.shield_points).to eql(50)
    end

    it "should be damaged when robot is wounded, before health is reduced" do
      @robot.wound(25)
      expect(@robot.shield_points).to eql(25)
      expect(@robot.health).to eql(100)
    end

    it "should be damaged first when robot wounded, then health is damaged" do
      @robot.wound(100)
      expect(@robot.shield_points).to eql(0)
      expect(@robot.health).to eql(50)
    end
  end

end