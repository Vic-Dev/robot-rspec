# The Robot class should keep track of all robots that are instantiated.

require 'spec_helper'

describe Robot do

  describe '#list' do

    it "should return an array of all robots instantiated" do
      Robot.class_variable_set(:@@list, [])
      @robot = Robot.new
      @robot2 = Robot.new
      expect(Robot.class_variable_get(:@@list)).to eql([@robot, @robot2])
    end

  end

end