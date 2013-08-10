require 'digest/sha2'

class User < ActiveRecord::Base
	validates_uniqueness_of :username

	def self.authenticate(username, password)
		user = User.first(:conditions => ['username = ?', username])
		if user.blank? || Digest::SHA256.hexdigest(password + user.password_salt) != user.password_hash
			raise "Invalid Username or Password."
		end
		user
	end

	def password=(pass)
		salt = [Array.new(6) {rand(256).chr}.join].pack("m").chomp
		self.password_salt, self.password_hash =
			salt, Digest::SHA256.hexdigest(pass + salt)
	end

end
