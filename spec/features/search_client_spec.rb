require 'rails_helper'

feature 'Client Search', js: true do
  let(:user) { create(:user) }

  before(:each) do
    create(:client, name: 'Eliseo Soriano', birthdate: '1947-04-04')
    create_list(:client, 5)

    sign_in user
    visit clients_path
  end

  scenario 'page should load 6 client by default' do
    page.should have_css("table tbody tr", count: 6)
  end

  scenario 'when searching for name' do
    within('#searchForm') do
      find(:xpath, '//input[@name="filters[name]"]').set('soriano')
      click_button 'search'
    end
    page.should have_css("table tbody tr", count: 1)
    page.should have_content('Eliseo Soriano')
  end

  scenario 'when searching with birthdate' do
    within('#searchForm') do
      find(:xpath, '//input[@name="filters[birthdate]"]').set('1947-04-04')
      click_button 'search'
    end
    page.should have_css("table tbody tr", count: 1)
    page.should have_content('Eliseo Soriano')
  end

  scenario 'when searching with birthdate with invalid name' do
    within('#searchForm') do
      find(:xpath, '//input[@name="filters[name]"]').set('daniel razon')
      find(:xpath, '//input[@name="filters[birthdate]"]').set('1947-04-04')
      click_button 'search'
    end
    page.should have_css("table tbody tr", count: 1)
    page.should have_content('No records yet.')
  end

  scenario 'when searching with birthdate with name' do
    within('#searchForm') do
      find(:xpath, '//input[@name="filters[name]"]').set('soriano')
      find(:xpath, '//input[@name="filters[birthdate]"]').set('1947-04-04')
      click_button 'search'
    end
    page.should have_css("table tbody tr", count: 1)
    page.should have_content('Eliseo Soriano')
  end
end
