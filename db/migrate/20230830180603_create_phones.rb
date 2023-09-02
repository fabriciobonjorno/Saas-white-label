# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones, id: :uuid do |t|
      t.string :number
      t.integer :kind, default: 0
      t.boolean :whatsapp, default: false
      t.references :phoneble, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
    add_index :phones, :number
    add_index :phones, :kind
  end
end
