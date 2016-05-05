# The Robot class can be asked to return all robots in a given position (x,y). It should return an array of all the robots since multiple robots could potentially be at position 0,0 (for example)
require 'spec_helper'

describe Robot do

  describe '#all_positions' do
    it 'should return an array of all robot positions' do
      Robot.class_variable_set(:@@list, [])
      @robot = Robot.new
      @robot2 = Robot.new
      expect(Robot.all_positions).to eql([@robot.position, @robot2.position])
    end
  end

end
