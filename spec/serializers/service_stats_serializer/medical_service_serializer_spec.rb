require 'rails_helper'

describe ServiceStatsSerializer::MedicalService do
  let(:serializer) do
    described_class.new(starts_from: starts_from, ends_to: ends_to)
  end

  context 'nothing to serialize' do
    let(:starts_from) { '2019-10-01' }
    let(:ends_to) { '2019-10-07' }

    let(:expectation) do
      {
        direction: :down,
        count: 0,
        prev: 0,
        diff_percentage: "-0%",
        range: "#{starts_from.to_time.strftime('%A, %B %e, %Y')} "\
               "- #{ends_to.to_time.strftime('%A, %B %e, %Y')}"
      }
    end

    it 'serializes' do
      expect(serializer.serializable_hash).to eq expectation
    end
  end

  context 'incremental stats' do
    let(:starts_from) { Time.now.beginning_of_week }
    let(:ends_to) { Time.now.end_of_week  }
    let(:expectation) do
      {
        direction: :up,
        count: 20,
        prev: 10,
        diff_percentage: "+50%",
        range: "#{starts_from.to_time.strftime('%A, %B %e, %Y')} "\
               "- #{ends_to.to_time.strftime('%A, %B %e, %Y')}"
      }
    end

    before do
      create_list(:client_record, 10, :last_week)
      create_list(:client_record, 20, :this_week)
    end

    it 'serializes' do
      expect(serializer.serializable_hash).to eq expectation
    end
  end

  context 'decremental stats' do
    let(:starts_from) { Time.now.beginning_of_week }
    let(:ends_to) { Time.now.end_of_week  }
    let(:expectation) do
      {
        direction: :down,
        count: 10,
        prev: 20,
        diff_percentage: "-50%",
        range: "#{starts_from.to_time.strftime('%A, %B %e, %Y')} "\
               "- #{ends_to.to_time.strftime('%A, %B %e, %Y')}"
      }
    end

    before do
      create_list(:client_record, 20, :last_week)
      create_list(:client_record, 10, :this_week)
    end

    it 'serializes' do
      expect(serializer.serializable_hash).to eq expectation
    end
  end
end
