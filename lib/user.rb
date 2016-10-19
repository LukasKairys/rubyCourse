# user
class User
  attr_reader :email, :type, :company
  def initialize(email, password, type)
    validate_password(password)
    @email = email
    @password = password
    @type = type
  end

  def assign_company(company)
    @company = company if @company.nil?
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
