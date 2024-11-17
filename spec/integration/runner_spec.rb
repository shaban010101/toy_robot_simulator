# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Runner' do
  context 'when the options and arguments provided are valid' do
    context 'when the file can be opened' do
      it 'outputs the robot coordinates' do
        output = <<~OUTPUT
          0,1,NORTH
          0,0,WEST
          3,3,NORTH
          4,4,NORTH
          2,3,WEST
          1,2,WEST
        OUTPUT
        expect(`./runner -f spec/fixtures/test.txt`).to eq(output)
      end
    end
    context 'when the file cannot be opened' do
      context 'when the file does exist' do
        it 'outputs an error message' do
          expect(`./runner -f file.tx`).to eq("Please enter a file which exists\n")
        end
      end

      context 'when the file is not a text file' do
        it 'outputs an error message' do
          expect(`./runner -f spec/fixtures/valid.csv`).to eq("Please only use a text file\n")
        end
      end
    end
  end

  context 'when the options and arguments provided are not valid' do
    it 'outputs an error message' do
      expect(`./runner -d`).to eq(
        "Please check the arguments and options you inputted\n"
      )
    end
  end
end
