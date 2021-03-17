class User < ApplicationRecord
    has_secure_password
    has_many :roles

    validates :name, presence: true
end
