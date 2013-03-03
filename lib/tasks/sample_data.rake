require 'faker'
require 'digest'

namespace :db do
  desc "fill the database with sample users and data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Example User",
                 :email => "example@example.com",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    
    10.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password = "password"
      User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
    end
    
    def range_rand(min,max)
      min+rand(max-min)
    end
    
    
    User.all(:limit => 6).each do |user|
      50.times do 
        user.books.create!(:title =>Faker::Lorem.sentence, :description => Faker::Lorem.sentence(5), 
                           :author_last=>Faker::Name.name, :author_first=>Faker::Name.name,
                           :genre => Faker::Lorem.sentence(1),  :year_published=>range_rand(1865,1984),
                           :isbn=> Digest::MD5.hexdigest(rand.to_s) )
      end
    end
        
 end 
end
    
