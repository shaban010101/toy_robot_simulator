require 'spec_helper'
require_relative '../../lib/file_reader'

RSpec.describe FileReader do
  subject(:file_reader) { described_class.new }

  describe '#run' do
    let(:operation_executor) { instance_double(OperationExecutor) }

    before do
      allow(OperationExecutor).to receive(:new).and_return(operation_executor)
    end

    context 'when the operation is recognised' do
      before do
        allow(operation_executor).to receive(:call).with(['PLACE', "0,0,NORTH"])
      end

      it 'performs the operation provided in the input' do
        expect(operation_executor).to receive(:call).with(['PLACE', "0,0,NORTH"])

        subject.run('spec/fixtures/valid.txt')
      end
    end

    context 'when the operation is not recognised' do
      before do
        allow(operation_executor).to receive(:call).with(['PLACES', "0,0,NORTH"])
      end

      it 'does not perform the operation' do
        expect(operation_executor).to receive(:call).with(['PLACES', "0,0,NORTH"])
        subject.run('spec/fixtures/invalid.txt')
      end
    end
  end
end
