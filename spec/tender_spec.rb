require 'tender'
require 'proposal'
describe Tender do
  context 'when deadline is set to two days ago' do
    it 'returns days to deadline as -1' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today - 2)
      expect(shipment_tender.count_days_to_deadline).to eq(-1)
    end
  end

  context 'when deadline is set to tomorrow' do
    it 'returns days to deadline as 1' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today + 1)
      expect(shipment_tender.count_days_to_deadline).to eq(1)
    end
  end

  context 'when deadline is set to today' do
    it 'returns days to deadline as 0' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today)
      expect(shipment_tender.count_days_to_deadline).to eq(0)
    end
  end

  context 'when deadline is still valid and max number
           of proposals is not reached and it is new company in tender' do
    it 'adds proposals' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today + 1)
      shipment_proposal = Proposal.new('UAB Tr', 100)

      expect(shipment_tender.add_proposal(shipment_proposal)).to be true
    end
  end

  context 'when deadline is over' do
    it 'do not adds proposals' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today - 1)
      shipment_proposal = Proposal.new('UAB Tr', 100)

      expect(shipment_tender.add_proposal(shipment_proposal)).to be false
    end
  end

  context 'when max number of proposals is reached' do
    it 'do not adds proposals' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today + 1)
      shipment_proposal = Proposal.new('UAB Tr', 100)

      shipment_tender.max_proposals_count.times do
        shipment_tender.add_proposal(shipment_proposal)
      end

      expect(shipment_tender.add_proposal(shipment_proposal)).to be false
    end
  end

  context 'when proposal with same company name already exists' do
    it 'do not adds proposals' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today + 1)
      shipment_proposal = Proposal.new('UAB Tr', 100)

      shipment_tender.add_proposal(shipment_proposal)

      expect(shipment_tender.add_proposal(shipment_proposal)).to be false
    end
  end

  context 'when editing tender' do
    it 'clears all given proposals' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today)
      shipment_proposal = Proposal.new('UAB Tr', 100)

      shipment_tender.add_proposal(shipment_proposal)
      shipment_tender.edit('Import', 'Pants',
                           'Kaunas', 'Klaipeda', Date.today + 4) {}

      expect(shipment_tender.proposals.length).to eq(0)
    end
  end

  context 'when editing tender and there is proposals given' do
    it 'does call block with list of proposals' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today)
      shipment_proposal = Proposal.new('UAB Tr', 100)

      shipment_tender.add_proposal(shipment_proposal)

      expect do |b|
        shipment_tender.edit('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today, &b)
      end
        .to yield_with_args(shipment_proposal)
    end
  end

  context 'when editing tender and there is no proposals given' do
    it 'does not call block' do
      shipment_tender = described_class
                        .new('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today)

      expect do |b|
        shipment_tender.edit('Import', 'Shoes tender',
                             'Vilnius', 'Klaipeda', Date.today, &b)
      end
        .not_to yield_control
    end
  end
end
