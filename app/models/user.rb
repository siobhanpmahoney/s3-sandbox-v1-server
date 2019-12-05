class User < ApplicationRecord
	has_secure_password
	
	attr_accessor :remember_token, :activation_token, :reset_token

	alias :read_attribute_for_serialization :send

	  # alias :read_attribute_for_serialization :send
  # validates :password, presence: true, length: { in: 6..20 }, allow_nil: false


  # def User.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # def User.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # def authenticated?(attribute, token)
  #   digest = send("#{attribute}_digest")
  #   return false if digest.nil?
  #   BCrypt::Password.new(digest).is_password?(token)
  # end



  # def current_user?
  #   self == current_user
  # end



end
