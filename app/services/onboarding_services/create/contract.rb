# frozen_string_literal: true

module OnboardingServices
  module Create
    class Contract < ApplicationContract
      params do
        required(:company).hash do
          required(:document).filled(:str?)
          required(:trade_name).filled(:str?)
          required(:legal_name).filled(:str?)
          required(:address).hash do
            required(:zip_code).filled(:str?)
            required(:address).filled(:str?)
            required(:address_number).filled(:str?)
            optional(:complement).filled(:str?)
            required(:neighborhood).filled(:str?)
            required(:state).filled(:str?)
            required(:city).filled(:str?)
          end
          required(:phone).hash do
            required(:kind).filled(:str?)
            required(:number).filled(:str?)
          end
          required(:user).hash do
            required(:name).filled(:str?)
            required(:username).filled(:str?)
            required(:email).filled(:str?)
            required(:password).filled(:str?)
            required(:password_confirmation).filled(:str?)
          end
        end
      end
    end
  end
end