# Proposal class
class Proposal
  attr_reader :price, :company_name

  def initialize(company_name, price)
    @price = price
    @company_name = company_name
  end
end
