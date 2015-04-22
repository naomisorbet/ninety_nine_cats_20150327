class ChangeUserIdToOwnerId < ActiveRecord::Migration
  def change
    rename_column :cats, :user_id, :owner_id
  end
end
