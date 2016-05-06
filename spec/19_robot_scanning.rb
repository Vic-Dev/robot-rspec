# A given robot should be able to scan its surroundings (tiles immediately next to its current @position) Note: You should leverage the class method implemented in #18
require 'spec_helper'

describe Robot do
  
  describe '#scanner' do
    it "should return array of all robots within 1 square distance" do
      Robot.class_variable_set(:@@list, [])
      @robot = Robot.new("robot")
      @robot2 = Robot.new("robot2")
      @robot3 = Robot.new("robot3")
      allow(@robot2).to receive(:position).and_return([1,1])
      allow(@robot3).to receive(:position).and_return([4,4])
      expect(@robot.scanner).to eql([@robot2])
    end
  end

end
