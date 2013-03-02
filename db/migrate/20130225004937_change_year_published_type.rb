class ChangeYearPublishedType < ActiveRecord::Migration
  def change
    
    change_column(:books, :year_published, :string)
  end

  
end
