# frozen_string_literal: true

class DeviseCreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.timestamps null: false
    end

    add_index :candidates, :email,                unique: true
    add_index :candidates, :reset_password_token, unique: true
    # add_index :candidates, :confirmation_token,   unique: true
    # add_index :candidates, :unlock_token,         unique: true
  end
end
