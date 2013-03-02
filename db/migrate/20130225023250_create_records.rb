class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :owner_id
      t.integer :book_id

      t.timestamps
    end
  end
end
