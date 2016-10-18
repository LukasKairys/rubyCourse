# Proposal class
class Proposal
  attr_reader :price, :user

  def initialize(user, price)
    @price = price
    @user = user
  end
end
