# frozen_string_literal: true

class Address < ApplicationRecord
  before_save :sanitize_zip_code
  before_save :verify_number

  validates :zip_code, :address, :address_number,
            :neighborhood, :city, :state, presence: true

  belongs_to :addressable, polymorphic: true

  private

  def verify_number
    self.address_number = 'S/N' if address_number.nil? || address_number.empty?
  end

  def sanitize_zip_code
    zip_code.gsub!(/[^0-9]/, '')
  end
end
