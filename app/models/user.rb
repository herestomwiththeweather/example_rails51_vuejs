class User < ApplicationRecord
  validates :url, presence: true, uniqueness: true
end
