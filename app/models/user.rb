class User < ApplicationRecord
  has_secure_password
  before_save :email_lowercase


  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A\S+@\S+\z/ }
  validates :username, presence: true,
                      format: { with: /\A[a-zA-Z\d]+\z/i },
                      uniqueness: { case_sensitive: false }

private
  def email_lowercase
    self.email.downcase!
  end

  

end
