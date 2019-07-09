require 'rails_helper'

RSpec.describe 'A candidate filling in their personal details' do
  VALID_PERSONAL_DETAILS = {
    first_name: 'John',
    last_name: 'Doe',
    title: 'Dr',
    preferred_name: 'Dr Doe',
    nationality: 'British',
    date_of_birth: Date.new(1997, 3, 13)
  }.freeze

  it 'can enter details into the form, and see them on the finished application' do
    visit '/'
    click_on t('application_form.begin_button')

    expect(page).to have_content t('application_form.personal_details_section.heading')

    fill_in_personal_details(VALID_PERSONAL_DETAILS)

    click_on t('application_form.save_and_continue')

    expect(page).to have_content t('application_form.check_your_answers')
    expect(page).to have_content t('application_form.personal_details_section.heading')

    within '.govuk-summary-list' do
      expect_summary_to_include('first_name', 'John')
      expect_summary_to_include('last_name', 'Doe')
      expect_summary_to_include('title', 'Dr')
      expect_summary_to_include('preferred_name', 'Dr Doe')
      expect_summary_to_include('nationality', 'British')
      expect_summary_to_include('date_of_birth', '13 March 1997')
    end

    click_on t('application_form.submit')

    expect(page).to have_content t('application_form.application_submitted')
  end

  it 'can edit the Personal details section via the Check your answers page' do
    visit '/'
    click_on t('application_form.begin_button')

    # When I fill in the personal details form and submit it
    fill_in_personal_details(VALID_PERSONAL_DETAILS.merge(first_name: 'Zuleika'))
    click_on t('application_form.save_and_continue')

    # And I click the relevant "Change" button on the Check your answers page
    find('#change-first_name').click

    # Then I expect to see the details I entered earlier
    expect(page).to have_field('First name', with: 'Zuleika')

    # And when I submit the form with a changed first name
    fill_in t('application_form.personal_details_section.first_name.label'), with: 'Daphne'
    click_on t('application_form.save_and_continue')

    # Then I expect to see the Check your answers page again, with the new name in place
    expect(page).to have_content t('application_form.check_your_answers')
    expect_summary_to_include('first_name', 'Daphne')
  end

  def fill_in_personal_details(details)
    fill_in t('application_form.personal_details_section.title.label'), with: details[:title]
    fill_in t('application_form.personal_details_section.first_name.label'), with: details[:first_name]
    fill_in t('application_form.personal_details_section.preferred_name.label'), with: details[:preferred_name]
    fill_in t('application_form.personal_details_section.last_name.label'), with: details[:last_name]

    within '.govuk-date-input' do
      fill_in 'Day', with: details[:date_of_birth].day
      fill_in 'Month', with: details[:date_of_birth].month
      fill_in 'Year', with: details[:date_of_birth].year
    end

    fill_in t('application_form.personal_details_section.nationality.label'), with: details[:nationality]
  end

  # search for a <dt> with an expected name adjacent to a <dd> with an expected value
  def expect_summary_to_include(key, value)
    field_label = t("#{key}.label", scope: 'application_form.personal_details_section')
    expect(find('dt', text: field_label).find('+dd')).to have_content(value)
  end
end