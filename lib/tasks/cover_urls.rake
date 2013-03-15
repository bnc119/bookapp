
namespace :db do
  desc "fill the books in the database with generic cover urls"
  task :make_urls => :environment do
  
    Book.all.each do |book|
       book.cover_url = "http://www.goodreads.com/assets/nocover/111x148.png"
       book.save
    end
  end
 
end
    
