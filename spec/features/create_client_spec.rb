require 'rails_helper'

feature 'Client Creation', js: true do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
    visit clients_path
  end

  scenario 'when no client created yet' do
    expect(page).to have_content('No records yet.')
  end

  let(:name) { FFaker::Name.name }
  let(:birthdate) { '1987-04-15' }
  let(:contact) { '9477310731' }
  let(:occupation) { FFaker::Job.title }
  let(:address) { "#{FFaker::Address.secondary_address} #{FFaker::Address.street_address}" }

  scenario 'when creating a new client' do
    click_link 'Create New Client'
    expect(page).to have_content('Create new client')

    fill_in 'Name', with: name
    fill_in 'Birthdate', with: '1987-04-15'
    fill_in 'Contact number', with: contact
    fill_in 'Occupation', with: occupation
    fill_in 'Address', with: address
    click_button 'Create Client'
    expect(page).to have_content(name)
    expect(page).to have_content(birthdate.to_time.strftime('%b %e %Y'))
    # expect(page).to have_content("+65#{contact}")
  end
end
