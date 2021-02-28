class Role < ApplicationRecord
    belongs_to :user

    enum role: { Java: 0, Ruby: 1, Rust: 2 }
end
