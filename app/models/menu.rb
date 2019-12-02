class Menu < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :menu_type, presence: true
  enum menu_type: %w[meals drinks]

  has_many :orders
end