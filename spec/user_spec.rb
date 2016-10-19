require 'user'
require 'company'

describe User do
  it 'assigns company to a user' do
    user = described_class.new('a@a.lt', 'Aaaaaa', 'shipper')
    company = Company.new('test')
    user.assign_company(company)
    expect(user.company).to eq(company)
  end
  context 'when company is already assigned' do
    it 'do not let to change company name' do
      user = described_class.new('a@a.lt', 'Aaaaaa', 'shipper')
      company = Company.new('test')
      company2 = Company.new('test2')
      user.assign_company(company)
      user.assign_company(company2)
      expect(user.company).to eq(company)
    end
  end
  context 'when password with < 5 digits is given' do
    it 'raises argument error' do
      expect { described_class.new('a@a.lt', 'aaa', 'shipper') }
        .to raise_error(ArgumentError)
    end
  end
  context 'when password of correct length, but all small digits is given' do
    it 'raises argument error' do
      expect { described_class.new('a@a.lt', 'aaaaa', 'shipper') }
        .to raise_error(ArgumentError)
    end
  end
end
