class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author_last
      t.string :author_first
      t.text :description
      t.date :year_published
      t.string :genre

      t.timestamps
    end
  end
end
