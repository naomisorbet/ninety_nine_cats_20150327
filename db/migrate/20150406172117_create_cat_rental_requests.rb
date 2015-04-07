class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
