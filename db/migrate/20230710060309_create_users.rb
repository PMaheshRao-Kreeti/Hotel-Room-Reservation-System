# frozen_string_literal: true

# User table
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :phone, limit: 10, null: false, unique: true
      t.string :password_digest, null: false
      t.integer :role, null: false
      t.string :provider
      t.string :uid, unique: true

      t.timestamps
    end
  end
end
