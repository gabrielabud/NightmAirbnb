require 'bcrypt'
require 'dm-validations'

class User
  include BCrypt
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String
  property :username, String
  property :password_hash, Text

  has n, :bookings
  has n, :spaces

  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_uniqueness_of :email, :username

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
