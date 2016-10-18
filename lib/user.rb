# user
class User
  attr_reader :email, :type, :company
  def initialize(email, password, type)
    @email = email
    @password = password
    @type = type
  end

  def assign_company(company)
    @company = company if @company.nil?
  end
end
