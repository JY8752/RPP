class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :password, presence: true, length: { in: 6..20 }
end
