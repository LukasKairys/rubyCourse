require 'tender'
require 'proposal'
describe Tender do
  context 'when deadline is set to two days ago' do
    it 'returns days to deadline as -1' do
      shipment_tender = Tender.new('Import', 'Shoes tender',
                                   'Vilnius', 'Klaipeda', Date.today - 2)
      expect(shipment_tender.count_days_to_deadline).to eq(-1)
    end
  end

  context 'when deadline is set to tomorrow' do
    it 'returns days to deadline as 1' do
      shipment_tender = Tender.new('Import', 'Shoes tender',
                                   'Vilnius', 'Klaipeda', Date.today + 1)
      expect(shipment_tender.count_days_to_deadline).to eq(1)
    end
  end

  context 'when deadline is set to today' do
    it 'returns days to deadline as 0' do
      shipment_tender = Tender.new('Import', 'Shoes tender',
                                   'Vilnius', 'Klaipeda', Date.today)
      expect(shipment_tender.count_days_to_deadline).to eq(0)
    end
  end

  context 'when deadline is still valid and max number
           of proposals is not reached' do
    it 'adds proposals' do
      shipment_tender = Tender.new('Import', 'Shoes tender',
                                   'Vilnius', 'Klaipeda', Date.today + 1)
      shipment_proposal = Proposal.new('UAB Tr', 100)

      shipment_tender.add_proposal(shipment_proposal)

      expect(shipment_tender.proposals.length).to eq(1)
    end
  end
end
