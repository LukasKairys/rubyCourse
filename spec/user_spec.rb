require 'user'
require 'company'

describe User do
  it 'assigns company to a user' do
    user = described_class.new('a@a.lt', 'aaa', 'shipper')
    company = Company.new('test')
    user.assign_company(company)
    expect(user.company).to eq(company)
  end
  context 'when company is already assigned' do
    it 'do not let to change company name' do
      user = described_class.new('a@a.lt', 'aaa', 'shipper')
      company = Company.new('test')
      company2 = Company.new('test2')
      user.assign_company(company)
      user.assign_company(company2)
      expect(user.company).to eq(company)
    end
  end
end
