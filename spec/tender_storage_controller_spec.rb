require 'datastorage'
require 'tenderstoragecontroller'
require 'proposalsdata'

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
                                      Route.new('A', 'B')),
               ProposalsData.new(Date.today + 1))
  end
  let(:updated_tender) do
    Tender.new(ShipmentTenderData.new('Import', 'Wood tender',
                                      Route.new('A', 'B')),
               ProposalsData.new(Date.today + 1))
  end
  context 'when empty storage is passed' do
    it 'returns none tenders' do
      tender_storage_controller = described_class.new(storage)
      tenders = tender_storage_controller.tenders
      expect(tenders.length).to eq(0)
    end
  end

  context 'when storage is passed' do
    it 'loads its data' do
      storage_spy = object_double(DataStorage.new('test.yaml'),
                                  save_data: true, load_data: [tender])
      described_class.new(storage_spy)

      expect(storage_spy).to have_received(:load_data)
    end
  end

  context 'when storage with tender is passed' do
    it 'sets last id to last tenders id increased by 1' do
      tender.give_identity(5)
      storage_spy = object_double(DataStorage.new('test.yaml'),
                                  save_data: true, load_data: [tender])
      tender_storage_controller = described_class.new(storage_spy)

      expect(tender_storage_controller.last_id).to eql(tender.id + 1)
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
    it 'saves data in storage' do
      storage_spy = object_double(DataStorage.new('test.yaml'),
                                  save_data: true, load_data: [])
      tender_storage_controller = described_class.new(storage_spy)

      tender_storage_controller.add_new(tender)
      expect(storage_spy).to have_received(:save_data)
        .with(tender_storage_controller.tenders)
    end
  end

  context 'when tender is deleted' do
    it 'saves data in storage' do
      storage_spy = object_double(DataStorage.new('test.yaml'),
                                  save_data: true, load_data: [])
      tender_storage_controller = described_class.new(storage_spy)

      tender_storage_controller.remove_by_id(1)
      expect(storage_spy).to have_received(:save_data)
        .with(tender_storage_controller.tenders)
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
    it 'deletes previous one and returns new one' do
      tender_storage_controller = described_class.new(storage)
      tender.give_identity(1)
      updated_tender.give_identity(1)
      tender_storage_controller.add_new(tender)
      tender_storage_controller.update(updated_tender)
      tenders = tender_storage_controller.tenders
      expect(tenders[0]).to eq(updated_tender)
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
      tender_storage_controller.remove_by_id(1)
      expect(tender_storage_controller.last_id).to eq(1)
    end
  end
end
