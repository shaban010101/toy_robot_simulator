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
end