require 'proposal'
require 'route'
require 'shipmenttenderdata'
require 'tender'
require 'user'
require 'company'
require 'rspec/expectations'

RSpec::Matchers.define :have_valid_proposals_count do
  match do |proposal_data|
    return false if proposal_data.proposals.empty?
    proposal_data.proposals.length <= proposal_data.max_proposals_count
  end
end

describe ProposalsData do
  let(:shipment_proposal) do
    user = User.new('a@a.lt', 'Aaaaa')
    user.assign_company(Company.new('Test'))
    Proposal.new(user, 100)
  end

  let(:shipment_proposal2) do
    user = User.new('b@b.lt', 'Bbbbbb')
    user.assign_company(Company.new('Test2'))
    Proposal.new(user, 100)
  end

  let(:proposals_data_late) do
    described_class.new(Date.today - 1)
  end

  let(:proposals_data_tomorrow) do
    described_class.new(Date.today + 1)
  end

  let(:proposals_data_today) do
    described_class.new(Date.today)
  end

  context 'when deadline is set to one day ago' do
    it 'returns days to deadline as -1' do
      expect(proposals_data_late.count_days_to_deadline).to eq(-1)
    end
  end

  context 'when deadline is set to tomorrow' do
    it 'returns days to deadline as 1' do
      expect(proposals_data_tomorrow.count_days_to_deadline).to eq(1)
    end
  end

  context 'when deadline is set to today' do
    it 'returns days to deadline as 0' do
      expect(proposals_data_today.count_days_to_deadline).to eq(0)
    end
  end

  context 'when deadline is still valid and max number
           of proposals is not reached and it is new company in tender' do
    it 'adds proposals' do
      expect(proposals_data_tomorrow.add_proposal(shipment_proposal)).to be true
    end
  end

  context 'when deadline is over' do
    it 'do not adds proposals' do
      expect(proposals_data_late.add_proposal(shipment_proposal)).to be false
    end
  end

  context 'when max number of proposals is reached' do
    it 'do not adds proposals' do
      i = 1
      (proposals_data_today.max_proposals_count + 1).times do
        user = User.new('b@b.lt', 'Bbbbbb')
        user.assign_company(Company.new('Test #[i]'))
        new_prop = Proposal.new(user, 100)
        proposals_data_today.add_proposal(new_prop)
        i += 1
      end

      expect(proposals_data_today).to have_valid_proposals_count
    end
  end

  context 'when proposal with same company name already exists' do
    it 'do not adds proposals' do
      proposals_data_tomorrow.add_proposal(shipment_proposal)
      proposals_data_tomorrow.add_proposal(shipment_proposal2)
      expect(proposals_data_tomorrow
              .add_proposal(shipment_proposal)).to be false
    end
  end

  context 'when proposal with same company name does not exist' do
    it 'it adds proposals' do
      proposals_data_tomorrow.add_proposal(shipment_proposal)
      expect(proposals_data_tomorrow
              .add_proposal(shipment_proposal2)).to be true
    end
  end

  context 'when tender data changed is called' do
    it 'clears all given proposals' do
      proposals_data_tomorrow.add_proposal(shipment_proposal)
      proposals_data_tomorrow.tender_data_changed {}

      expect(proposals_data_tomorrow.proposals.length).to eq(0)
    end
  end

  # papildyti su kontekstu / papildyta i tender_spec
  context 'when tender data changed is called' do
    it 'does call block with list of proposals' do
      proposals_data_tomorrow.add_proposal(shipment_proposal)

      expect do |b|
        proposals_data_tomorrow.tender_data_changed(&b)
      end
        .to yield_with_args(shipment_proposal)
    end
  end

  context 'when tender data changed is called with empty prop' do
    it 'does not call block' do
      expect do |b|
        proposals_data_tomorrow.tender_data_changed(&b)
      end
        .not_to yield_control
    end
  end

  context 'when existing proposal company name is given' do
    it 'sets winning proposal' do
      proposals_data_tomorrow.add_proposal(shipment_proposal)

      proposals_data_tomorrow.select_winner(shipment_proposal.user.company.name)
      expect(proposals_data_tomorrow.winner_proposal).to eq(shipment_proposal)
    end
  end

  context 'when not existing proposal company name is given' do
    it 'raises error' do
      proposals_data_tomorrow.add_proposal(shipment_proposal)

      expect { proposals_data_tomorrow.select_winner('zzzzzzz') }
        .to raise_error(ArgumentError, 'Not existing')
    end
  end

  # added after mutant
  context 'when proposals data is created' do
    it 'it sets max proposal count to 6 and given deadline' do
      expect(proposals_data_today.max_proposals_count).to eq(6)
      expect(proposals_data_today.deadline).to eq(Date.today)
    end
  end
end
