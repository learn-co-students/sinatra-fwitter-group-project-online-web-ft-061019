class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    unslugged = slug.gsub("-", " ")
    self.find_by(username: unslugged)
  end

end