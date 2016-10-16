require 'datastorage'

describe DataStorage do
  FILENAME = 'data/test_data.json'.freeze
  before(:all) do
    File.open(FILENAME, 'w+')
  end
  let(:storage) do
    DataStorage.new(FILENAME)
  end
  let(:data) do
    'test'
  end
  after(:all) do
    File.delete(FILENAME)
  end

  context 'when data is passed for saving' do
    it 'stores data into file' do
      storage.save_data(data)
      loaded_data = storage.load_data

      expect(loaded_data).to eq(data)
    end
  end
end
