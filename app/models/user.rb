class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_movies, through: :favorites, source: :movie

  has_secure_password

  before_save :email_lowercase

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A\S+@\S+\z/ }
  validates :username, presence: true,
                      format: { with: /\A[a-zA-Z\d]+\z/i },
                      uniqueness: { case_sensitive: false }

  scope :by_name, -> { order(name: :desc) }
  scope :not_admins, -> { by_name.where(admin: false) }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end

  def self.authenticate(email_or_username, password)
    user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)
    user && user.authenticate(password)
  end

private
  def email_lowercase
    self.email.downcase!
  end

end
