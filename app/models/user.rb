# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :timeoutable,
         :trackable

  validates :name, :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validate :password_regex
  validate :username_regex

  has_one :address, as: :addressable, dependent: :destroy
  has_many :phones, as: :phoneble, dependent: :destroy
  belongs_to :company
  belongs_to :profile

  private

  def username_regex
    return if username.blank? || username =~ /^[a-zA-Z0-9_-]{3,10}$/

    errors.add :base, I18n.t('user.errors.username')
  end

  def password_regex
    return if password.blank? || password =~ /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)[^ ]{8,}\z/

    errors.add :base, I18n.t('user.errors.password')
  end
end
