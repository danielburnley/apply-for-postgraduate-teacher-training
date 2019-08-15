require 'notifications/client'

class TTApplicationSubmissionsController < ApplicationController
  def create
    client = Notifications::Client.new(ENV.fetch('GOVUK_NOTIFY_API_KEY'))
    client.send_email(
      email_address: 'sender@something.com',
      template_id: 'dummy-template-id',
    )

    redirect_to(tt_application_path)
  end
end
