require_relative '../spec_helper'
require_relative '../../app/models/company'

describe User, type: 'model' do
  it 'assigns company to a user' do
    user = described_class.new('a@a.lt', 'Aaaaaa')
    company = Company.new('test')
    user.assign_company(company)
    expect(user.company).to eq(company)
  end
  context 'when company is already assigned' do
    it 'do not let to change company name' do
      user = described_class.new('a@a.lt', 'Aaaaaa')
      company = Company.new('test')
      company2 = Company.new('test2')
      user.assign_company(company)
      user.assign_company(company2)
      expect(user.company).to eq(company)
    end
  end
  context 'when password with < 5 digits is given' do
    it 'raises argument error' do
      expect { described_class.new('a@a.lt', 'aaaa') }
        .to raise_error(ArgumentError, 'Password is too weak.' \
                                       'It must contain at least 5 digits')
    end
  end
  context 'when password of correct length, but all small digits is given' do
    it 'raises argument error' do
      expect { described_class.new('a@a.lt', 'aaaaa') }
        .to raise_error(ArgumentError, 'Password is too weak.' \
                                       'It must contain at least ' \
                                       'one capital letter')
    end
  end

  # added after mutant
  it 'assigns email and password to a user' do
    user = described_class.new('a@a.lt', 'Aaaaaa')
    expect(user.company.name).to eq('Empty')
    expect(user.email). to eq('a@a.lt')
    expect(user.password). to eq('Aaaaaa')
  end
end
