require 'spec_helper'
require_relative '../../lib/simulator'

RSpec.describe Simulator do
  subject(:simulate) { described_class.new }

  describe "#place" do
    context "when the x and y axis exist" do
      it "moves the robot to a place" do
        simulate.place(0,0,'NORTH')
        expect(simulate.report).to eq("0,0,NORTH")
      end
    end

    context "when the x and y axis values do not exist" do
      it "does not move the robot to a place" do
        simulate.place(5,5,'NORTH')
        expect(simulate.report).to eq(nil)
      end
    end

    context "when the facing value does not exist" do
      it "does not move the robot to a place" do
        simulate.place(0,0,'NORTHS')
        expect(simulate.report).to eq(nil)
      end
    end
  end

  describe '#move' do
    context "when the toy can move" do
      it 'moves the toy forward' do
        simulate.place(0,0,'NORTH')
        simulate.move
        expect(simulate.report).to eq('0,1,NORTH')
      end
    end

    context "when the toy cannot move" do
      it 'does not move the toy forward' do
        simulate.place(0,0,'SOUTH')
        simulate.move
        expect(simulate.report).to eq('0,0,SOUTH')
      end
    end
  end

  describe '#left' do
    described_class::LEFT_DIRECTION.each do |current_direction, _turn_direction|
      it "turns the robot left" do
        simulate.place(0,0, current_direction)
        simulate.left
        expect(simulate.report).to eq("0,0,#{described_class::LEFT_DIRECTION[current_direction]}")
      end
    end
  end

  describe '#right' do
    described_class::RIGHT_DIRECTION.each do |current_direction, _turn_direction|
      it "turns the robot right" do
        simulate.place(0,0, current_direction)
        simulate.right
        expect(simulate.report).to eq("0,0,#{described_class::RIGHT_DIRECTION[current_direction]}")
      end
    end
  end
end