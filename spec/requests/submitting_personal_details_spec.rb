require 'rails_helper'

describe 'Submitting personal details' do
  context 'with an invalid date' do
    let(:params) do
      {
        personal_details: {
          'date_of_birth(3i)' => 99,
          'date_of_birth(2i)' => 99,
          'date_of_birth(1i)' => 9999
        }
      }
    end

    it 'does not throw an exception' do
      post '/personal_details', params: params
    end
  end
end
