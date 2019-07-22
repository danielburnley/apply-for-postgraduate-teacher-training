class ResidencyStatusController < ApplicationController
  def new
    @residency_status = PersonalDetails.new
  end

  def create; end
end
