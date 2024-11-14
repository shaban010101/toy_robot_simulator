require 'spec_helper'
require_relative '../../lib/simulator'

RSpec.describe Simulator do
  subject(:simulate) { described_class.new }

  describe "#place" do
    it "moves the robot to a place" do
      simulate.place(0,0,'NORTH')
      expect(simulate.report).to eq("0,0,NORTH")
    end
  end
end