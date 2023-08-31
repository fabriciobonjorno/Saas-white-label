# frozen_string_literal: true

class AddProfileToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :profile, null: false, foreign_key: true, type: :uuid
  end
end
