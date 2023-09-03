# frozen_string_literal: true

class OnboardingController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    result = OnboardingServices::Create::Transaction.new.call(params)
    if result.success?
      redirect_to new_user_session_path, notice: 'Cadastro realizado com sucesso!'
    else
      redirect_to onboarding_path, alert: result.failure
    end
  end
end
