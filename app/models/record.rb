class Record < ActiveRecord::Base
  
  attr_accessible :book_id
  
  belongs_to :owner, :class_name => "User" 
  belongs_to :book
  
  validates :owner_id, :presence => true
  validates :book_id,  :presence => true
end
