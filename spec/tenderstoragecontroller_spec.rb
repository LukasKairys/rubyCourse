require 'datastorage'
require 'tenderstoragecontroller'

describe TenderStorageController do
  let(:storage_test_filename) do
    'data/test_data.json'
  end
  let(:storage) do
    DataStorage.new(storage_test_filename)
  end
  context 'when empty storage is passed' do
    it 'should return none tenders' do
      tender_storage_controller = described_class.new(storage)
      tenders = tender_storage_controller.tenders
      expect(tenders.length).to eq(0)
    end
  end
end
