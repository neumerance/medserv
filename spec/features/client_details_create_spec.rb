require 'rails_helper'

feature 'Client Details Create', js: true do
  let(:user) { create(:user) }
  let!(:client) { create(:client) }

  before(:each) do
    sign_in user
    visit client_path(id: client.id)
  end

  scenario 'When creating a new client record' do
    click_link 'Create New Record'
    page.should have_content("New records for #{client.name.titleize}")

    fill_in 'Systolic', with: 120
    fill_in 'Diastolic', with: 80
    fill_in 'Heart rate', with: 72
    fill_in 'Weight', with: 75
    click_button 'Save'

    within("#clientRecords") do
      page.should have_content('120')
      page.should have_content('80')
      page.should have_content('72')
      page.should have_content('75')
    end
  end
end
