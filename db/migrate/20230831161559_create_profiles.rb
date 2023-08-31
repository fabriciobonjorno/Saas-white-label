# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :name
      t.string :key
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :profiles, :name
    add_index :profiles, :key
  end
end
