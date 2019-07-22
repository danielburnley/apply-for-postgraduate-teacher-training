require 'rails_helper'

describe 'A candidate entering personal details' do
  include TestHelpers::PersonalDetails

  context 'who successfully enters their details' do
    context 'when nationality is in the European Economic Area' do
      before do
        visit '/'
        click_on t('application_form.begin_button')

        fill_in_personal_details(nationality: 'British')

        click_on t('application_form.save_and_continue')
      end

      it 'sees a summary of those details' do
        visit '/check_your_answers'

        expect(page).to have_content('First name John')
        # expect(page).to have_content('Residency status UK citizen')
      end
    end

    context 'when nationality is not in European Economic Area' do
      before do
        visit '/'
        click_on t('application_form.begin_button')

        fill_in_personal_details(nationality: 'Australian')

        click_on t('application_form.save_and_continue')
      end

      it 'sees another question about nationality' do
        expect(page).to have_content('What is your residency status?')
      end

      context 'who chooses a type 2 visa' do
        before do
          choose 'I have a tier 2 visa'
          click_on t('application_form.save_and_continue')
        end

        it 'sees that visa as their residency status' do
          visit '/check_your_answers'
          expect(page).to have_content('Residency status Tier 2 Visa')
        end
      end
    end
  end

  context 'and wishes to amend their details' do
    it 'can go back and edit them' do
      visit '/'
      click_on t('application_form.begin_button')

      fill_in_personal_details
      click_on t('application_form.save_and_continue')

      visit '/check_your_answers'
      find('#change-first_name').click

      expect(page).to have_field('First name', with: 'John')
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
end
