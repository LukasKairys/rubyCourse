# Proposal class
class Proposal < ActiveRecord::Base
  attr_reader :price, :user

  def initialize(user, price)
    @price = price
    @user = user
  end
end
