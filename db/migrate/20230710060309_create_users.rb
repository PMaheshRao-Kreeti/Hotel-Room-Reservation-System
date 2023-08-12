# frozen_string_literal: true

# User table
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :password_digest
      t.integer :role, default: 1
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
