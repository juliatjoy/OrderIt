class Menu < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :orders
end