# frozen_string_literal: true

class Address < ApplicationRecord
  before_save :sanitize_zip_code

  validates :zip_code, :address, :address_number,
            :neighborhood, :city, :state, presence: true

  belongs_to :addressable, polymorphic: true

  private

  def sanitize_zip_code
    zip_code.gsub!(/[^0-9]/, '')
  end
end
