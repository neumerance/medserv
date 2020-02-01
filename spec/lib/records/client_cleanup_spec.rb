require 'rails_helper'

describe Records::ClientCleanup do
  let!(:clients) { create_list(:client, 5, :with_client_records) }
  let(:expectation) { Client.all.map(&:name).map(&:upcase).sort }

  subject { described_class.new }

  it 'it upcase all clients' do
    subject.clean
    expect(clients.map(&:name).map(&:upcase).sort).to eq expectation
  end

  describe 'duplicate cleanup' do
    let!(:name) { 'MANG JOSE' }
    let!(:birthdate) { '1987-04-01' }
    let(:clients) do
      build_list(
        :client, 2,
        name: name,
        birthdate: birthdate
      )
    end
    let(:expectation) do
      Client.where(name: name, birthdate: birthdate)
    end

    before do
      clients.each do |client|
        client.save(validate: false)
        create_list(:client_record, 2, client: client)
      end
    end

    it 'it removes duplicates' do
      subject.clean
      expect(expectation.size).to eq 1
      expect(expectation.map(&:client_records).flatten.size).to eq 4
    end
  end
end
