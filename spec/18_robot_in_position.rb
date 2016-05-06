# The Robot class can be asked to return all robots in a given position (x,y). It should return an array of all the robots since multiple robots could potentially be at position 0,0 (for example)
require 'spec_helper'

describe Robot do

  describe '#all_in_position' do
    it 'should return an array of all robot in position [0, 0]' do
      Robot.class_variable_set(:@@list, [])
      @robot = Robot.new
      @robot2 = Robot.new
      expect(Robot.all_in_position(0, 0)).to eql([@robot, @robot2])
    end
  end

end
