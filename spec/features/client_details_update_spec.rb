require 'rails_helper'

feature 'Client Details Create', js: true do
  let(:user) { create(:user) }
  let(:client_record) { create(:client_record) }
  let(:client) { client_record.client }

  before(:each) do
    sign_in user
  end

  context 'client record lists' do
    let(:remarks) { FFaker::Lorem.sentence }
    let(:findings) { FFaker::Lorem.paragraph }
    before do
      visit client_path(id: client.id)
    end

    scenario 'table' do
      within("#clientRecords") do
        click_link 'Edit'
      end

      page.should have_content("Updating records for #{client.name.titleize}")

      fill_in 'Remarks', with: remarks
      fill_in 'Findings', with: findings
      click_button 'Save'

      page.should have_content(remarks)
      page.should have_content(findings)
    end
  end
end
