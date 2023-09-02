# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_831_170_716) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'addresses', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'zip_code'
    t.string 'address'
    t.string 'address_number'
    t.string 'complement'
    t.string 'state'
    t.string 'city'
    t.string 'neighborhood'
    t.string 'addressable_type', null: false
    t.uuid 'addressable_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['address'], name: 'index_addresses_on_address'
    t.index ['address_number'], name: 'index_addresses_on_address_number'
    t.index %w[addressable_type addressable_id], name: 'index_addresses_on_addressable'
    t.index ['city'], name: 'index_addresses_on_city'
    t.index ['complement'], name: 'index_addresses_on_complement'
    t.index ['neighborhood'], name: 'index_addresses_on_neighborhood'
    t.index ['state'], name: 'index_addresses_on_state'
    t.index ['zip_code'], name: 'index_addresses_on_zip_code'
  end

  create_table 'companies', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'document'
    t.string 'legal_name'
    t.string 'trade_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['document'], name: 'index_companies_on_document'
    t.index ['legal_name'], name: 'index_companies_on_legal_name'
    t.index ['trade_name'], name: 'index_companies_on_trade_name'
  end

  create_table 'permissions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'key'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.uuid 'parent_id'
    t.index ['key'], name: 'index_permissions_on_key'
    t.index ['name'], name: 'index_permissions_on_name'
    t.index ['parent_id'], name: 'index_permissions_on_parent_id'
  end

  create_table 'permissions_profiles', id: false, force: :cascade do |t|
    t.bigint 'profile_id', null: false
    t.bigint 'permission_id', null: false
    t.index %w[profile_id permission_id], name: 'index_permissions_profiles_on_profile_id_and_permission_id'
  end

  create_table 'phones', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'number'
    t.integer 'kind', default: 0
    t.boolean 'whatsapp', default: false
    t.string 'phoneble_type', null: false
    t.uuid 'phoneble_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['kind'], name: 'index_phones_on_kind'
    t.index ['number'], name: 'index_phones_on_number'
    t.index %w[phoneble_type phoneble_id], name: 'index_phones_on_phoneble'
  end

  create_table 'profiles', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'key'
    t.uuid 'company_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_profiles_on_company_id'
    t.index ['key'], name: 'index_profiles_on_key'
    t.index ['name'], name: 'index_profiles_on_name'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.string 'username'
    t.uuid 'company_id', null: false
    t.uuid 'profile_id', null: false
    t.index ['company_id'], name: 'index_users_on_company_id'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['name'], name: 'index_users_on_name'
    t.index ['profile_id'], name: 'index_users_on_profile_id'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['username'], name: 'index_users_on_username'
  end

  add_foreign_key 'permissions', 'permissions', column: 'parent_id'
  add_foreign_key 'profiles', 'companies'
  add_foreign_key 'users', 'companies'
  add_foreign_key 'users', 'profiles'
end
