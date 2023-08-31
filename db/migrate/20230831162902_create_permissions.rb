# frozen_string_literal: true

class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions, id: :uuid do |t|
      t.string :name
      t.string :key

      t.timestamps
    end
    add_index :permissions, :name
    add_index :permissions, :key
  end
end
