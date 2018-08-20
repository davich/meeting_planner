require 'rspec'
require 'planner'

RSpec.describe 'Planner' do
  describe 'meeting_planner' do
    subject { Planner.new(slots_a, slots_b, dur).meeting_planner }
    context 'overlap' do
      let(:slots_a) { [[10, 50], [60, 120], [140, 210]] }
      let(:slots_b) { [[0, 15], [51, 70]] }
      let(:dur) { 8 }
      it 'returns a timeslot start and end time' do
        expect(subject).to eq([60, 68])
      end
    end

    context 'no overlap' do
      let(:slots_a) { [[10, 50], [60, 120], [140, 210]] }
      let(:slots_b) { [[0, 15], [60, 70]] }
      let(:dur) { 12 }
      it 'returns nil if there no overlap between time slots' do
        expect(subject).to eq(nil)
      end
    end
  end
end
