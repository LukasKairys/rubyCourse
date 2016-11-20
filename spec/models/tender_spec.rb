require_relative '../../app/models/proposal'
require_relative '../../app/models/route'
require_relative '../../app/models/shipment_tender_datum'
require_relative '../../app/models/tender'
require_relative '../../app/models/user'
require_relative '../../app/models/company'
require_relative '../../app/models/proposals_datum'
require_relative '../spec_helper'

describe Tender, type: 'model' do
  fixtures :all

  let(:shipment_tender_tomorrow) do
    tenders(:tender_one)
  end

  let(:shipment_tender_edited_data) do
    shipment_tender_data(:shipment_tender_data_one)
  end

  # mockus pafixinti , kad ifa tikrintu kazkoki
  # rubocop rspec, mutant rubocop --require rubocop-rspec

  context 'when editing tender' do
    it 'changes shipment tender_data' do
      shipment_tender_tomorrow.edit(shipment_tender_edited_data) {}

      expect(shipment_tender_tomorrow.shipment_tender_datum)
        .to eq(shipment_tender_edited_data)
    end
  end

  context 'when editing tender and there is proposals' do
    it 'informs @proposals_data about the change' do
      proposals_data_spy = object_double(
        proposals_data(:proposals_datum_future),
        tender_data_changed: true, proposals: [1]
      )
      tender = described_class.new(
        shipment_tender_datum: shipment_tender_data(:shipment_tender_data_empty)
      )

      allow(tender).to receive(:proposals_datum) { proposals_data_spy }
      tender.edit(shipment_tender_edited_data)
      expect(proposals_data_spy).to have_received(:tender_data_changed)
    end
  end

  context 'when editing tender and there is no proposals' do
    it 'informs @proposals_data about the change' do
      proposals_data_spy = object_double(
        proposals_data(:proposals_datum_future),
        tender_data_changed: true, proposals: []
      )
      tender = described_class.new(
        shipment_tender_datum: shipment_tender_data(:shipment_tender_data_empty)
      )

      allow(tender).to receive(:proposals_datum) { proposals_data_spy }
      tender.edit(shipment_tender_edited_data)
      expect(proposals_data_spy).not_to have_received(:tender_data_changed)
    end
  end

  # Testuojam logika
  context 'when editing tender' do
    it 'notifies each user by sending email' do
      expect { shipment_tender_tomorrow.edit(shipment_tender_edited_data) }
        .to output("Email sent to: #{users(:user_one).email}\n").to_stdout
    end
  end

  context 'when calling to_s method' do
    it 'returns string with id, type and name' do
      expect(shipment_tender_tomorrow.to_s)
        .to eq("Id: #{shipment_tender_tomorrow.id}, " \
               "Type: #{shipment_tender_tomorrow.shipment_tender_datum
                        .shipment_type}, " \
               "Name: #{shipment_tender_tomorrow.shipment_tender_datum.name}, "\
               'Proposals count: ' \
               "#{shipment_tender_tomorrow.proposals_datum.proposals.length}")
    end
  end
end
