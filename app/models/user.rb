# Module for system user
class User < ActiveRecord::Base
  attr_reader :email, :password, :company
  has_one :company

  def initialize(email, password)
    validate_password(password)
    @email = email
    @password = password
    @company = Company.new('Empty')
  end

  def assign_company(company_to_assign)
    @company = company_to_assign if company.name.eql?('Empty')
  end

  def validate_password(password)
    raise ArgumentError, 'Password is too weak.' \
                         'It must contain at least 5 digits' if password
                                                                .length < 5
    raise ArgumentError, 'Password is too weak.' \
                         'It must contain at least ' \
                         'one capital letter' unless password =~ /[A-Z]/
  end
end
