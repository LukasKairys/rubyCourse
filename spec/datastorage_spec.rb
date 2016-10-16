require 'datastorage'

describe DataStorage do
  let(:storage_test_filename) do
    'data/test_data.json'
  end
  let(:storage) do
    DataStorage.new(storage_test_filename)
  end
  let(:data) do
    'test'
  end
  after(:all) do
    File.delete(storage_test_filename)
  end

  context 'when data is passed for saving' do
    it 'stores data into file' do
      storage.save_data(data)
      loaded_data = storage.load_data

      expect(loaded_data).to eq(data)
    end
  end
end
