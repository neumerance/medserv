require 'rails_helper'

feature 'Client Details', js: true do
  let(:user) { create(:user) }
  let!(:client) { create(:client) }

  before(:each) do
    sign_in user
    visit clients_path
  end

  scenario 'viewing client details' do
    within("#client-#{client.id}") do
      click_link 'Details'
    end
    expect(page).to have_content(client.name.titleize)
  end
end
