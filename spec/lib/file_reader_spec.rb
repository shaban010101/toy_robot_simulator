# frozen_string_literal: true

require 'spec_helper'
require 'file_reader'

RSpec.describe FileReader do
  subject(:file_reader) { described_class.new(file) }

  describe '#run' do
    let(:operation_executor) { instance_double(OperationExecutor) }

    before do
      allow(OperationExecutor).to receive(:new).and_return(operation_executor)
    end

    context 'when the file is valid' do
      context 'when the operation is recognised' do
        let(:file) { 'spec/fixtures/valid.txt' }
        before do
          allow(operation_executor).to receive(:call).with(['PLACE', '0,0,NORTH'])
        end

        it 'performs the operation provided in the input' do
          expect(operation_executor).to receive(:call).with(['PLACE', '0,0,NORTH'])

          file_reader.run
        end
      end

      context 'when the operation is not recognised' do
        let(:file) { 'spec/fixtures/invalid.txt' }

        before do
          allow(operation_executor).to receive(:call).with(['PLACES', '0,0,NORTH']).and_return(false)
          allow($stdout).to receive(:puts).with('unrecognised command: PLACES 0,0,NORTH on line 1')
        end

        it 'attempts to perform the operation but returns an error' do
          expect($stdout).to receive(:puts).with("Unrecognised command 'PLACES 0,0,NORTH' on line 1")
          file_reader.run
        end
      end
    end

    context 'when the file is not valid' do
      context 'when the file is in the wrong format' do
        let(:file) { 'spec/fixtures/valid.csv' }

        it 'does not perform the operation' do
          expect(operation_executor).not_to receive(:call)

          file_reader.run
        end

        it 'outputs an error message' do
          expect($stdout).to receive(:puts).with('Please only use a text file')
          file_reader.run
        end
      end

      context 'when the file does not exist' do
        let(:file) { 'spec/fixtures/valids.txt' }

        it 'does not perform the operation' do
          expect(operation_executor).not_to receive(:call)

          file_reader.run
        end

        it 'outputs an error message' do
          expect($stdout).to receive(:puts).with('Please enter a file which exists')
          file_reader.run
        end
      end
    end
  end
end
