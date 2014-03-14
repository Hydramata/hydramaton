class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # The following Devise shim methods are present to override the behavior that
  # Devise is expecting, but is NOT typically delivered by CAS
  attr_accessor :password # Devise shim
  def password_required?; false; end # Devise shim
  def email_required?; false; end # Devise shim
  def update_with_password(attributes); self.update(attributes); end # Devise shim

end
