class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.string  :account_name
      t.integer :account_type
      t.integer :user_id
	
      t.timestamps
    end
  end
end
