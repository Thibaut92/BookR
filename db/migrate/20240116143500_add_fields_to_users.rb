class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string unless column_exists?(:users, :first_name)
    add_column :users, :last_name, :string unless column_exists?(:users, :last_name)
    add_column :users, :company_name, :string unless column_exists?(:users, :company_name)
    add_column :users, :siret, :string unless column_exists?(:users, :siret)
    add_column :users, :phone, :string unless column_exists?(:users, :phone)
    add_column :users, :account_type, :integer, default: 0 unless column_exists?(:users, :account_type)
    add_column :users, :business_category, :string unless column_exists?(:users, :business_category)
    
    add_index :users, :siret, unique: true unless index_exists?(:users, :siret)
  end
end
