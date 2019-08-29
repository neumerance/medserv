require 'rails_helper'

feature 'Client Details Create', js: true do
  let(:user) { create(:user) }
  let!(:client) { create(:client) }

  before(:each) do
    sign_in user
  end

  context 'client records' do
    scenario 'table' do
      visit client_path(id: client.id)
      within("#clientRecords") do
        page.should have_content('No records yet.')
      end
    end
  end

  context 'client record lists' do
    before do
      create_list(:client_record, 5, client_id: client.id)
    end

    scenario 'table' do
      visit client_path(id: client.id)
      within("#clientRecords") do
        page.should have_css("table tbody tr", count: 10)
      end
    end
  end
end
