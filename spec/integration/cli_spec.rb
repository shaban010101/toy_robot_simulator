# frozen_string_literal: true

require 'spec_helper'
require 'cli'
require 'console_interface'

RSpec.describe CLI do
  describe "#run" do
    subject(:run) { described_class.new(console_interface: console_interface).run }
    let(:console_interface) { ConsoleInterface.new(input: input, output: output) }
    let(:output) { StringIO.new }

    before do
      allow(output).to receive(:puts).with('> ')
      allow(output).to receive(:puts).with("type ? for help")
      allow(output).to receive(:puts).with("EXITING")
    end

    context "when the command is ?" do
      let(:input) { StringIO.new("?\nX\n") }


      it "outputs the help text" do
        expect(output).to receive(:puts).with(described_class::HELP_TEXT)
        run
      end
    end


    context "when the command is X" do
      let(:input) { StringIO.new("X\n") }

      it "outputs the exit text" do
        expect(output).to receive(:puts).with("EXITING")
        run
      end
    end


    context "when the command is X" do
      let(:input) { StringIO.new("PLACE 0,1,NORTH\nREPORT\nX\n") }

      it "outputs the coordinates" do
        expect(output).to receive(:puts).with("0,1,NORTH")
        run
      end
    end

    context "when the command is not a recognised command" do
      let(:input) { StringIO.new("PLACES\nX\n") }

      it "outputs Unrecognised Command" do
        expect(output).to receive(:puts).with("Unrecognised Command 'PLACES'")

        run
      end
    end
  end
end
