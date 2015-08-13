require 'data_mapper'
require 'bcrypt'

class User
  include DataMapper::Resource

  attr_reader :password
  #Writable so it acts like the setter method for password below
  attr_accessor :password_confirmation

  property :id, Serial

  #the required: true negates the need for validates_presence_of :email
  property :email, String, required: true

  #stores password and salt
  #needs to be text rather than string
  #so it can store more than 50 characters
  property :password_digest, Text

  # validates_confirmation_of is a DataMapper method
  # provided especially for validating confirmation passwords!
  # The model will not save unless both password
  # and password_confirmation are the same
  # read more about it in the documentation
  # http://datamapper.org/docs/validations.html
  validates_confirmation_of :password
  validates_uniqueness_of :email

  # when assigned the password, we don't store it directly
  # instead, we generate a password digest, that looks like this:
  # "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa"
  # and save it in the database. This digest, provided by bcrypt,
  # has both the password hash and the salt. We save it to the
  # database instead of the plain password for security reasons.
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    User.first(email: email)
  end
end