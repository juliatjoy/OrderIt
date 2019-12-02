class Order < ApplicationRecord
  belongs_to :user
  belngs_to :menu
end