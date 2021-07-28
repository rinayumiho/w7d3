class User < ApplicationRecord
    validates :username, :password_digest, presence: true
    validates :username, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}

    attr_reader :password

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return user if user && user.is_password?(password)
        nil
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest) == password
    end


end
