# Proposal class
class Proposal < ApplicationRecord
  # attr_reader :price, :user
  belongs_to :proposals_datum
  belongs_to :user

  validates_presence_of :price, :user
  # def initialize(user, price)
  #   @price = price
  #   @user = user
  # end
end
