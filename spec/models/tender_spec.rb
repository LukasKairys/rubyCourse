require_relative '../../app/models/proposal'
require_relative '../../app/models/route'
require_relative '../../app/models/shipment_tender_datum'
require_relative '../../app/models/tender'
require_relative '../../app/models/user'
require_relative '../../app/models/company'
require_relative '../../app/models/proposals_datum'
require_relative '../spec_helper'

describe Tender, type: 'model' do
  let(:test_user) do
    company = Company.new('Test')
    user = User.new('test@test.lt', 'randomSecurepassword')
    user.assign_company(company)
    return user
  end
  let(:shipment_tender_tomorrow) do
    proposals_data = ProposalsDatum.new(Date.today + 1)
    proposals_data.add_proposal(Proposal.new(test_user, 100))
    described_class.new(
      ShipmentTenderDatum.new('Import', 'Shoes tender',
                              Route.new('A', 'C')),
      proposals_data
    )
  end

  let(:shipment_tender_edited_data) do
    ShipmentTenderDatum.new('Export', 'Wood tender',
                            Route.new('C', 'A'))
  end

  context 'when editing tender' do
    it 'changes shipment tender_data' do
      shipment_tender_tomorrow.edit(shipment_tender_edited_data) {}

      expect(shipment_tender_tomorrow.shipment_tender_data)
        .to eq(shipment_tender_edited_data)
    end
  end

  context 'when editing tender' do
    it 'informs @proposals_data about the change' do
      proposals_data_spy = object_double(ProposalsDatum.new(Date.today),
                                         tender_data_changed: true)
      tender = described_class.new(
        ShipmentTenderDatum.new('Import', 'Shoes tender',
                                Route.new('A', 'B')),
        proposals_data_spy
      )

      tender.edit(shipment_tender_edited_data)
      expect(proposals_data_spy).to have_received(:tender_data_changed)
    end
  end

  # Testuojam logika
  context 'when editing tender' do
    it 'notifies each user by sending email' do
      expect { shipment_tender_tomorrow.edit(shipment_tender_edited_data) }
        .to output("Email sent to: #{test_user.email}\n").to_stdout
    end
  end

  context 'when id is previously not set (default: -1)' do
    it 'sets the id given' do
      shipment_tender_tomorrow.give_identity(1)
      expect(shipment_tender_tomorrow.id).to eq(1)
    end
  end

  context 'when id is previously set (not default: -1)' do
    it 'leaves previous id' do
      shipment_tender_tomorrow.give_identity(3)
      shipment_tender_tomorrow.give_identity(4)
      expect(shipment_tender_tomorrow.id).to eq(3)
    end
  end

  context 'when calling to_s method' do
    it 'returns string with id, type and name' do
      expect(shipment_tender_tomorrow.to_s)
        .to eq("Id: #{shipment_tender_tomorrow.id}, " \
               "Type: #{shipment_tender_tomorrow.shipment_tender_data.type}, " \
               "Name: #{shipment_tender_tomorrow.shipment_tender_data.name}, " \
               'Proposals count: ' \
               "#{shipment_tender_tomorrow.proposals_data.proposals.length}")
    end
  end
end
