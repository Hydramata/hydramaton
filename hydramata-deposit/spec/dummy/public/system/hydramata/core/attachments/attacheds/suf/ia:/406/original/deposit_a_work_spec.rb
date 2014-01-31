require 'spec_helper'

describe "Depositing a work" do
  let(:work_type) { 'article' }
  it 'creates a work draft' do
    visit hydramata_deposit.new_work_path(work_type)

    within('form#new_work') do
      fill_in('Title', with: "A Verbose Treatise")
      fill_in('Abstract', with: "Lorem ipsum")
      attach_file('Files', __FILE__)
    end
    click_on("Create Article")

    require 'byebug'; byebug; true;
    within('.presenter.presenter-article') do
      expect(page).to have_selector('.attribute.title', text: "A Verbose Treatise")
      expect(page).to have_selector('.attribute.abstract', text: "Lorem ipsum")
    end
    click_on("Edit this article")

    within('form#edit_work') do
      fill_in('Title', with: "An alternate treatise")
    end
    click_on("Update Article")

    within('.presenter.presenter-article') do
      expect(page).to have_selector('.attribute.title', text: "An alternate treatise")
      expect(page).to have_selector('.attribute.abstract', text: "Lorem ipsum")
    end

  end
end
