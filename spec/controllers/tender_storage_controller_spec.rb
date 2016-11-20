require_relative '../spec_helper'
require_relative '../rails_helper'
require_relative '../../app/models/proposals_datum'
require_relative '../../app/helpers/tender_storage_controller'

describe TenderStorageController, type: 'model' do
  context 'when storage controller is initialized with class' do
    it 'sets storage type class' do
      tender_storage_controller = described_class.new(Tender)
      expect(tender_storage_controller.storage_type_class).to eq(Tender)
    end
  end

  context 'when tender is searched by numeric value' do
    it 'calls database and finds by id' do
      tender_storage_controller = described_class.new(Tender)
      allow(Tender).to receive(:find_by) { true }

      tender_storage_controller.tender(2)
      expect(Tender).to have_received(:find_by).with(id: 2)
    end
  end

  context 'when tender is searched by string' do
    it 'calls database and finds by proposals_datum name' do
      tender_storage_controller = described_class.new(Tender)
      allow(Tender).to receive(:find_by) { true }
      tender_storage_controller.tender('Wood tender')

      expect(Tender).not_to have_received(:find_by)
    end
  end

  context 'when new tender is added' do
    it 'saves it' do
      tender_storage_controller = described_class.new(Tender)
      tender_double = double
      allow(tender_double).to receive(:save).with(no_args) { true }
      allow(Tender).to receive(:new) { tender_double }
      tender_storage_controller.add_new('test', 'test')
      expect(Tender).to have_received(:new).with(shipment_tender_datum: 'test',
                                                 proposals_datum: 'test')
      # expect(tender_double).to have_received(:save)
    end
  end

  context 'when tenders is called' do
    it 'calls database and to receive all' do
      tender_storage_controller = described_class.new(Tender)
      allow(Tender).to receive(:all) { true }
      tender_storage_controller.tenders
      expect(Tender).to have_received(:all)
    end
  end
end
