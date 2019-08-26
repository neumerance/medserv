require 'rails_helper'

describe Client, type: :model do
  it { should have_many(:client_records) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:birthdate) }
  it { should validate_presence_of(:contact_number) }
  it { should validate_presence_of(:occupation) }

  describe 'scopes' do
    context 'when filtering by name' do
      let!(:client) { create(:client, name: 'Daniel Razon') }
      subject { Client.search_by_name('aniel') }

      it { is_expected.not_to be_empty }
    end

    context 'when filtering by birthdate' do
      let!(:client) { create(:client, birthdate: '1987-04-15') }
      subject { Client.search_by_birthdate('1987-04-15') }

      it { is_expected.not_to be_empty }
    end

    context 'when filtering with filter method' do
      let!(:client) { create(:client, name: 'Daniel Razon', birthdate: '1987-04-15') }
      subject { Client.filter(filters) }

      context 'name' do
        let(:filters) { { name: 'aniel' } }
        it { is_expected.not_to be_empty }
      end

      context 'birthdate' do
        let(:filters) { { birtdate: '1987-04-15' } }
        it { is_expected.not_to be_empty }
      end

      context 'both valid filters' do
        let(:filters) do
          {
            name: 'aniel',
            birthdate: '1987-04-15'
          }
        end
        it { is_expected.not_to be_empty }
      end

      context 'has unsearchable filter' do
        let(:filters) do
          {
            name: 'aniel',
            birthdate: '1987-03-15'
          }
        end
        it { is_expected.to be_empty }
      end
    end
  end
end
