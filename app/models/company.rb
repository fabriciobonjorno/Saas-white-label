# frozen_string_literal: true

class Company < ApplicationRecord
  before_save :sanitize_document

  validates :document, :legal_name, :trade_name, presence: true
  validates :document, :legal_name, uniqueness: { case_sensitive: false }
  validate :valid_document

  has_one :address, as: :addressable, dependent: :destroy
  has_many :phones, as: :phoneble, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_many :users, dependent: :destroy

  private

  def valid_document
    errors.add :base, I18n.t('company.errors.document') unless CNPJ.valid?(document)
  end

  def sanitize_document
    document.gsub!(/[^0-9]/, '')
  end
end
