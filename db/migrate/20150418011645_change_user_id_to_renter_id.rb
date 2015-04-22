class ChangeUserIdToRenterId < ActiveRecord::Migration
  def change
    rename_column :cat_rental_requests, :user_id, :renter_id
  end
end
