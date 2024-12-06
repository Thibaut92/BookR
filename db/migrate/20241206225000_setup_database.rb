class SetupDatabase < ActiveRecord::Migration[8.0]
  def change
    # Create Users table with all needed fields
    create_table :users do |t|
      # Devise fields
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      # Custom fields
      t.string :company_name
      t.string :siret
      t.string :phone
      t.integer :account_type
      t.string :business_subcategory
      t.string :company_type

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :siret,               unique: true

    # Create Meetings table
    create_table :meetings do |t|
      t.references :industrial, null: false, foreign_key: { to_table: :users }
      t.references :project_manager, null: false, foreign_key: { to_table: :users }
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.text :notes
      t.string :location
      t.string :meeting_type

      t.timestamps
    end
  end
end
