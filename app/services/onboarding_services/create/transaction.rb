# frozen_string_literal: true

module OnboardingServices
  module Create
    class Transaction < MainService
      step :validate_params
      step :verify_params
      step :create

      def validate_params(params)
        validation = validate_contract(params)
        validation.success? ? Success(params) : Failure(validation.errors.to_h)
      end

      def verify_params(params)
        clean_params(params)
        errors = []

        company = build_company(params[:company])
        errors << company.errors.full_messages unless company.valid?

        phone = company.phones.build(params[:company][:phone])
        errors << phone.errors.full_messages unless phone.valid?

        build_default_profile(company)
        user = company.users.build(params[:company][:user])
        user.profile = company.profiles.first
        errors << user.errors.full_messages unless user.valid?

        if errors.empty?
          Success(params)
        else
          Failure(errors)
        end
      end

      def create(params)
        company = build_company(params[:company])
        company.build_address(params[:company][:address])
        company.phones.build(params[:company][:phone])
        build_default_profile(company)
        user = company.users.build(params[:company][:user])
        user.profile = company.profiles.first

        if company.save
          Success(company)
        else
          Failure(company.errors.full_messages.to_sentence)
        end
      end

      private

      def validate_contract(params)
        Contract.call(params.permit!.to_h)
      end

      def clean_params(params)
        params[:company][:phone][:number].gsub!(/[^0-9]/, '')
        params[:company][:document].gsub!(/[^0-9]/, '')
      end

      def build_company(company_params)
        Company.new(company_params.slice('document', 'legal_name', 'trade_name'))
      end

      def build_default_profile(company)
        company.profiles.build(name: 'Admin', key: 'admin')
      end
    end
  end
end
