require 'rails_helper'

describe 'A candidate entering personal details' do
  include TestHelpers::PersonalDetails

  context 'who successfully enters their details' do
    before do
      visit '/'
      click_on t('application_form.begin_button')

      fill_in_personal_details

      click_on t('application_form.save_and_continue')
    end

    it 'sees a summary of those details' do
      expect(page).to have_content('First name John')
    end

    context 'and wishes to amend their details' do
      it 'can go back and edit them' do
        find('#change-first_name').click
        expect(page).to have_field('First name', with: 'John')
      end
    end
  end

  context 'who leaves out a required field' do
    before do
      visit '/'
      click_on t('application_form.begin_button')
      click_on t('application_form.save_and_continue')
    end

    it 'sees an error summary with clickable links', js: true do
      expect(page).to have_content('There is a problem')
      click_on 'Enter your first name'
      expect(page).to have_selector('#personal_details_first_name:focus')
    end
  end

  xcontext 'who is trying to correct an incomplete date of birth' do
    before do
      visit '/'
      click_on t('application_form.begin_button')
      fill_in_personal_details
      fill_in 'Year', with: ''
      click_on t('application_form.save_and_continue')
      click_on 'Enter your date of birth'
    end

    it 'is guided to the "day" field', js: true do
      expect(page).to have_selector('#personal_details_day_of_birth:focus')
    end
  end
end
