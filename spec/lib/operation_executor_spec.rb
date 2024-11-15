require 'spec_helper'
require './lib/operation_executor'
require './lib/simulator'


RSpec.describe OperationExecutor do
  describe '#call' do
    context 'when the operation is recognised' do
      it 'performs the operation provided in the input' do
        expect(Simulator).to receive(:new).and_call_original

        subject.call(['PLACE', "0,0,NORTH"])
      end
    end

    context 'when the operation is not recognised' do
      it 'does not perform the operation' do
        expect(subject.call(['PLACES'])).to eq(false)
      end
    end
  end

  describe "#place" do
    let(:simulator) { instance_double(Simulator) }

    before do
      allow(Simulator).to receive(:new).and_return(simulator)
    end

    it "places the robot" do
      expect(simulator).to receive(:place).with(0,0, "NORTH")
      subject.call(['PLACE', "0,0,NORTH"])
    end
  end

  describe "#move" do
    let(:simulator) { instance_double(Simulator) }

    before do
      allow(Simulator).to receive(:new).and_return(simulator)
      allow(simulator).to receive(:place).with(0,0, "NORTH")

      subject.call(['PLACE', "0,0,NORTH"])
    end

    it "places the robot" do
      expect(simulator).to receive(:move)

      subject.call(['MOVE'])
    end
  end

  describe "#right" do
    let(:simulator) { instance_double(Simulator) }

    before do
      allow(Simulator).to receive(:new).and_return(simulator)
      allow(simulator).to receive(:place).with(0,0, "NORTH")

      subject.call(['PLACE', "0,0,NORTH"])
    end

    it "turns the robot right" do
      expect(simulator).to receive(:right)

      subject.call(['RIGHT'])
    end
  end

  describe "#left" do
    let(:simulator) { instance_double(Simulator) }

    before do
      allow(Simulator).to receive(:new).and_return(simulator)
      allow(simulator).to receive(:place).with(0,0, "NORTH")
      subject.call(['PLACE', "0,0,NORTH"])
    end

    it "places the robot" do
      expect(simulator).to receive(:left)

      subject.call(['LEFT'])
    end
  end

  describe "#report" do
    let(:simulator) { instance_double(Simulator) }

    before do
      allow(Simulator).to receive(:new).and_return(simulator)
      allow(simulator).to receive(:place).with(0,0, "NORTH")
      subject.call(['PLACE', "0,0,NORTH"])
    end

    it "report where the robot is" do
      expect(simulator).to receive(:report)

      subject.call(['REPORT'])
    end
  end
end