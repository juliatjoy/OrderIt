class Restaurant < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :menus
end