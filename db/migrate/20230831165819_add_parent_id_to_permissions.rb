# frozen_string_literal: true

class AddParentIdToPermissions < ActiveRecord::Migration[7.0]
  def change
    add_reference :permissions, :parent, foreign_key: { to_table: :permissions }, type: :uuid
  end
end
