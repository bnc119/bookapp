require 'digest'

class User < ActiveRecord::Base

  has_many :records, :foreign_key => :owner_id, :dependent => :destroy
  has_many :books, :through => :records, :dependent =>:destroy
  
  
	# allows mass-assignment of the following attributes
	attr_accessible :name, :email, :password, :password_confirmation
	
	#create getters and setters on this raw class
	attr_accessor :password
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :name,  :presence => true,
										:length => { :maximum => 50 }
	validates :email, :presence => true,
									  :format => { :with =>email_regex},
									  :uniqueness => { :case_sensitive => false}
									  
	validates :password, :presence => true, 
											 :confirmation => true, 
											 :length => { :within => 6..40 }
											 
	before_save :encrypt_password
	
	# this is the public API into the password machinery
	def has_password?(submitted_password)
		#compare encrypted password with the encrypted version of submitted_password
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email, submitted_password)
		user = User.find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
		#(user && user.has_password?(submitted_password)) ? user : nil
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
		
	private
	
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
	
end
