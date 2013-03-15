class AddCoverUrlToBooks < ActiveRecord::Migration
  def change
  	add_column(:books, :cover_url, :string) 
  end
end
