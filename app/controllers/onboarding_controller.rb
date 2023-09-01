# frozen_string_literal: true

class OnboardingController < ApplicationController
  def new
    @company = Company.new
    # @onboard.build_address
    # @onboard.phone.build
    # @onboard.user.build
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to company_url(@company), notice: 'Company was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:document, :legal_name, :trade_name)
  end
end
