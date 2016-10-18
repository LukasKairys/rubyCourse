require 'datastorage'
require 'tenderstoragecontroller'

describe TenderStorageController do
  FILENAME = 'data/test_data.yaml'.freeze
  before(:each) do
    File.open(FILENAME, 'w+')
  end
  after(:each) do
    File.delete(FILENAME)
  end
  let(:storage) do
    DataStorage.new(FILENAME)
  end
  let(:tender) do
    Tender.new(ShipmentTenderData.new('Export', 'Wood tender',
                                      Route.new('Vilnius', 'Kaunas'),
                                      Date.today))
  end
  let(:updated_tender) do
    Tender.new(ShipmentTenderData.new('Import', 'Wood tender',
                                      Route.new('Vilnius', 'Kaunas'),
                                      Date.today))
  end
  context 'when empty storage is passed' do
    it 'returns none tenders' do
      tender_storage_controller = described_class.new(storage)
      tenders = tender_storage_controller.tenders
      expect(tenders.length).to eq(0)
    end
  end

  context 'when new tender is added' do
    it 'stores it' do
      tender_storage_controller = described_class.new(storage)
      tender_storage_controller.add_new(tender)
      tenders = tender_storage_controller.tenders
      expect(tenders.length).to eq(1)
    end
  end

  context 'when new tender is added' do
    it 'increases last id' do
      tender_storage_controller = described_class.new(storage)
      expect { tender_storage_controller.add_new(tender) }
        .to change(tender_storage_controller, :last_id)
        .from(0).to(1)
    end
  end

  context 'when modified tender is passed' do
    it 'updates deletes previous one and returns new one' do
      tender_storage_controller = described_class.new(storage)
      tender_storage_controller.add_new(tender)
      tender_storage_controller.update(updated_tender)
      tenders = tender_storage_controller.tenders
      expect(tenders[1]).to eq(updated_tender)
    end
  end

  it 'removes tender by id' do
    tender_storage_controller = described_class.new(storage)
    tender_storage_controller.add_new(tender)
    tender_storage_controller.remove_by_id(0)
    tenders = tender_storage_controller.tenders
    expect(tenders.length).to eq(0)
  end

  context 'when all tenders are deleted' do
    it 'sets last id to 0' do
      tender_storage_controller = described_class.new(storage)
      tender_storage_controller.add_new(tender)
      tender_storage_controller.remove_by_id(0)
      expect(tender_storage_controller.last_id).to eq(0)
    end
  end

  context 'when not last tender is deleted' do
    it 'last id should not be modified' do
      tender_storage_controller = described_class.new(storage)
      tender_storage_controller.add_new(tender)
      tender_storage_controller.add_new(updated_tender)
      temp_last_id = tender_storage_controller.last_id
      tender_storage_controller.remove_by_id(2)
      expect(temp_last_id).to eq(tender_storage_controller.last_id)
    end
  end

  context 'when latest tender is deleted' do
    it 'last id should be set to latest id + 1' do
      tender_storage_controller = described_class.new(storage)
      tender_storage_controller.add_new(tender)
      tender_storage_controller.add_new(updated_tender)
      tender_storage_controller.remove_by_id(2)
      expect(tender_storage_controller.last_id).to eq(2)
    end
  end
end
