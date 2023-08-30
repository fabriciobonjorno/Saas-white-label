# frozen_string_literal: true

class AddExtraInfoToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_reference :users, :company, null: false, foreign_key: true, type: :uuid
    add_index :users, :name
    add_index :users, :username
  end
end
