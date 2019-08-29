require 'rails_helper'

feature 'Client Updates', js: true do
  let(:user) { create(:user) }
  let!(:client) { create(:client) }

  before(:each) do
    sign_in user
    visit clients_path
  end

  scenario 'updating an existing client' do
    within("#client-#{client.id}") do
      click_link 'Edit'
    end
    expect(page).to have_content("Updating #{client.name.titleize}")

    fill_in 'Name', with: 'JonJon'
    click_button 'Update Client'
    within("#client-#{client.id}") do
      expect(page).to have_content('JonJon')
    end
  end
end
