# frozen_string_literal: true

class Phone < ApplicationRecord
  before_save :sanitize_number

  validates :kind, :number, presence: true
  validates :number, uniqueness: true

  enum kind: %i[commercial personal]

  belongs_to :phoneble, polymorphic: true

  private

  def sanitize_number
    number.gsub!(/[^0-9]/, '')
  end
end
