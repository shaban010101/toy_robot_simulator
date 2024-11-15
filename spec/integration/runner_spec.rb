require 'spec_helper'

RSpec.describe do
  context "when the file can be opened" do
    it "outputs the robot coordinates" do
      expect(`./runner test.txt`).to eq("0,1,NORTH\n0,0,WEST\n3,3,NORTH\n")
    end
  end

  context "when the file cannot be opened" do
    context "when the file does exist" do
      it "outputs an error message" do
        expect(`./runner file.tx`).to eq("Please enter a file which exists\n")
      end
    end

    context "when the file is not a text file" do
      it "outputs an error message" do
        expect(`./runner`).to eq("Please provide the correct argument e.g. example.txt\n")
      end
    end

    context "when the file is not a text file" do
      it "outputs an error message" do
        expect(`./runner sample.csv`).to eq("Please only use a text file\n")
      end
    end
  end
end