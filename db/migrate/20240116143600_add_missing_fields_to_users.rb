class AddMissingFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:users, :first_name)
      add_column :users, :first_name, :string
    end
    
    unless column_exists?(:users, :last_name)
      add_column :users, :last_name, :string
    end
    
    unless column_exists?(:users, :phone)
      add_column :users, :phone, :string
    end
    
    unless column_exists?(:users, :business_category)
      add_column :users, :business_category, :string
    end
  end
end

class AddMissingFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    # Cette migration n'est plus nécessaire car toutes les colonnes sont gérées dans la première migration
  end
end
