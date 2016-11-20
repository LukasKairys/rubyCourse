# Module for system user
class User < ApplicationRecord
  has_one :company
  has_many :proposals
  validates_format_of :email,
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                      on: 'create'
  validates_uniqueness_of :email

  after_initialize do
    validate_password(password)
  end

  def assign_company(company_to_assign)
    self.company = company_to_assign unless company
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
