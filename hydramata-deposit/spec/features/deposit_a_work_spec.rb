require 'spec_helper'

describe "Depositing a work" do
  let(:work_type) { 'article' }
  it 'creates a work draft' do
    visit hydramata_deposit.new_work_path(work_type)

    within('form#new_work') do
      fill_in('Title', with: "A Verbose Treatise")
      fill_in('Abstract', with: "Lorem ipsum")
      click_on("Create Article")
    end

    # Assumption we are redirecting to the edit action
    within('form#edit_work') do
      expect(page).to have_field('Title', with: "A Verbose Treatise")
      expect(page).to have_field('Abstract', with: "Lorem ipsum")
      expect(page).to have_button("Update Article")
    end
  end
end
