# frozen_string_literal: true

class Permission < ApplicationRecord
  belongs_to :parent, class_name: 'Task', optional: true
  has_many :actions, class_name: 'Task',
                     foreign_key: :parent_id, dependent: :destroy
  has_and_belongs_to_many :profiles
end
