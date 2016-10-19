require 'proposal'
require 'route'
require 'shipmenttenderdata'
require 'tender'
require 'user'
require 'company'
require 'rspec/expectations'

RSpec::Matchers.define :have_valid_proposals_count do
  match do |tender|
    tender.proposals.length < (tender.max_proposals_count + 1)
  end
end

describe Tender do
  let(:shipment_tender_late_data) do
    ShipmentTenderData.new('Import', 'Shoes tender',
                           Route.new('Vilnius', 'Klaipeda'), Date.today - 2)
  end

  let(:shipment_tender_tomorrow_data) do
    ShipmentTenderData.new('Import', 'Shoes tender',
                           Route.new('Vilnius', 'Klaipeda'), Date.today + 2)
  end

  let(:shipment_tender_today_data) do
    ShipmentTenderData.new('Import', 'Shoes tender',
                           Route.new('Vilnius', 'Klaipeda'), Date.today)
  end

  let(:shipment_tender_edited_data) do
    ShipmentTenderData.new('Export', 'Wood tender',
                           Route.new('Vilnius', 'Kaunas'), Date.today)
  end

  let(:shipment_proposal) do
    user = User.new('a@a.lt', 'a', 'forwarder')
    user.assign_company(Company.new('Test'))
    Proposal.new(user, 100)
  end

  context 'when deadline is set to two days ago' do
    it 'returns days to deadline as -1' do
      shipment_tender = described_class.new(shipment_tender_late_data)
      expect(shipment_tender.count_days_to_deadline).to eq(-1)
    end
  end

  context 'when deadline is set to tomorrow' do
    it 'returns days to deadline as 1' do
      shipment_tender = described_class.new(shipment_tender_tomorrow_data)
      expect(shipment_tender.count_days_to_deadline).to eq(2)
    end
  end

  context 'when deadline is set to today' do
    it 'returns days to deadline as 0' do
      shipment_tender = described_class.new(shipment_tender_today_data)
      expect(shipment_tender.count_days_to_deadline).to eq(0)
    end
  end

  context 'when deadline is still valid and max number
           of proposals is not reached and it is new company in tender' do
    it 'adds proposals' do
      shipment_tender = described_class.new(shipment_tender_tomorrow_data)
      expect(shipment_tender.add_proposal(shipment_proposal)).to be true
    end
  end

  context 'when deadline is over' do
    it 'do not adds proposals' do
      shipment_tender = described_class.new(shipment_tender_late_data)
      expect(shipment_tender.add_proposal(shipment_proposal)).to be false
    end
  end

  context 'when max number of proposals is reached' do
    it 'do not adds proposals' do
      shipment_tender = described_class.new(shipment_tender_tomorrow_data)

      shipment_tender.max_proposals_count.times do
        shipment_tender.add_proposal(shipment_proposal)
      end
      expect(shipment_tender).to have_valid_proposals_count
    end
  end

  context 'when proposal with same company name already exists' do
    it 'do not adds proposals' do
      shipment_tender = described_class.new(shipment_tender_tomorrow_data)

      shipment_tender.add_proposal(shipment_proposal)

      expect(shipment_tender.add_proposal(shipment_proposal)).to be false
    end
  end

  context 'when editing tender' do
    it 'clears all given proposals' do
      shipment_tender = described_class.new(shipment_tender_tomorrow_data)

      shipment_tender.add_proposal(shipment_proposal)
      shipment_tender.edit(shipment_tender_edited_data) {}

      expect(shipment_tender.proposals.length).to eq(0)
    end
  end

  context 'when editing tender and there is proposals given' do
    it 'does call block with list of proposals' do
      shipment_tender = described_class.new(shipment_tender_tomorrow_data)

      shipment_tender.add_proposal(shipment_proposal)

      expect do |b|
        shipment_tender.edit(shipment_tender_edited_data, &b)
      end
        .to yield_with_args(shipment_proposal)
    end
  end

  context 'when editing tender and there is no proposals given' do
    it 'does not call block' do
      shipment_tender = described_class.new(shipment_tender_today_data)

      expect do |b|
        shipment_tender.edit(shipment_tender_edited_data, &b)
      end
        .not_to yield_control
    end
  end

  context 'when calling to_s method' do
    it 'returns string with id, type and name' do
      shipment_tender = described_class.new(shipment_tender_tomorrow_data)

      expect(shipment_tender.to_s)
        .to eq("Id: #{shipment_tender.id}, " \
               "Type: #{shipment_tender.shipment_tender_data.type}, " \
               "Name: #{shipment_tender.shipment_tender_data.name}" \
               "Proposals count: #{shipment_tender.proposals.length}")
    end
  end
end
