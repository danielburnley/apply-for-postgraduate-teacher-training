require 'rails_helper'

describe ResidencyStatus do
  it { is_expected.to be_valid }

  it { is_expected.to respond_to(:visa_status) }
end
