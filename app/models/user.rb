class User < ActiveRecord::Base
  include Sluggable

  sluggable_column :username

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 4}

  def admin?
    self.role == 'admin'
  end
end