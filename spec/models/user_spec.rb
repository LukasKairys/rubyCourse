require_relative '../spec_helper'
require_relative '../../app/models/company'

describe User, type: 'model' do
  it 'assigns company to a user' do
    user = users(:user_one)
    company = companies(:company_one)
    user.assign_company(company)
    expect(user.company).to eq(company)
  end
  context 'when company is already assigned' do
    it 'do not let to change company name' do
      user = users(:user_one)
      company = companies(:company_one)
      company2 = companies(:company_two)
      user.assign_company(company)
      user.assign_company(company2)
      expect(user.company).to eq(company)
    end
  end
  context 'when password with < 5 digits is given' do
    it 'raises argument error' do
      expect { users(:user_short_pass) }
        .to raise_error(ArgumentError, 'Password is too weak.' \
                                       'It must contain at least 5 digits')
    end
  end
  context 'when password of correct length, but all small digits is given' do
    it 'raises argument error' do
      expect { users(:user_lowercase_pass) }
        .to raise_error(ArgumentError, 'Password is too weak.' \
                                       'It must contain at least ' \
                                       'one capital letter')
    end
  end

  # added after mutant
  # it 'assigns email and password to a user' do
  #   user = users(:user_one)
  #   expect(user.company.name).to eq('Empty')
  #   expect(user.email). to eq('a@a.lt')
  #   expect(user.password). to eq('Aaaaaa')
  # end
end
