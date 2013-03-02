class Book < ActiveRecord::Base

  has_many :records
  has_many :owners, :through => :records, :source => :owner  
  # :source parameter which explicitly tells Rails that the source of the owners array is the set of "owner"_id.
  
  
  validates  :title, :presence => true 
  validates  :author_first, :presence => true
  validates  :author_last, :presence => true 
  
  validates  :isbn, :presence => true, 
                    :uniqueness => { :case_sensitive => false}

  attr_accessible :title, :author_first, :author_last, 
                  :description, :year_published, :genre, :isbn 

end
