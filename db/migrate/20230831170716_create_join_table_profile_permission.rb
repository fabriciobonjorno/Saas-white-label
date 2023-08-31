# frozen_string_literal: true

class CreateJoinTableProfilePermission < ActiveRecord::Migration[7.0]
  def change
    create_join_table :profiles, :permissions do |t|
      t.index %i[profile_id permission_id]
      # t.index [:permission_id, :profile_id]
    end
  end
end
