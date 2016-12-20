class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :roles
  has_and_belongs_to_many :players

  validates :email, uniqueness: true

  def admin?
    roles_array = []
    self.roles.map { |x| roles_array << x.name }
    if roles_array.include? "admin"
      return true
    end
  end
end
