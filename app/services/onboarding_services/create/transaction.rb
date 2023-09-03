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
        params[:company][:phone][:number] = params[:company][:phone][:number].gsub!(/[^0-9]/, '')
        params[:company][:document] = params[:company][:document].gsub!(/[^0-9]/, '')

        errors = []
        company = params[:company].slice('document', 'legal_name', 'trade_name')
        register = Company.new(company)
        errors << register.errors.full_messages unless register.valid?
        phone = register.phones.build(params[:company][:phone])
        errors << phone.errors.full_messages unless phone.valid?
        register.profiles.build(name: 'Admin', key: 'admin')
        user = register.users.build(params[:company][:user])
        register.users.first.profile = register.profiles.first
        errors << user.errors.full_messages unless user.valid?
        errors

        if errors.nil? || errors.empty?
          Success(params)
        else
          Failure(errors)
        end       
      end

      def create(params)
        company = params[:company].slice('document', 'legal_name', 'trade_name')
        register = Company.new(company)
        register.build_address(params[:company][:address])
        register.phones.build(params[:company][:phone])
        register.profiles.build(name: 'Admin', key: 'admin')
        register.users.build(params[:company][:user])
        register.users.first.profile = register.profiles.first
        if register.save
          Success(register)
        else
          Failure(register.errors.full_messages.to_sentence)
        end
      end
     
      private

      def validate_contract(params)
        Contract.call(params.permit!.to_h)
      end      
    end
  end
end