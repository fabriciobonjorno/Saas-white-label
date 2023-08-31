# frozen_string_literal: true

class Profile < ApplicationRecord
  has_many :users
  belongs_to :company
  has_and_belongs_to_many :permissions
end
