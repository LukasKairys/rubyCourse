require_relative '../spec_helper'
require_relative '../rails_helper'
require_relative '../../app/controllers/data_storage'
require_relative '../../app/models/route'

describe DataStorage, type: 'model' do
  # FILENAME = 'data/test_data.yaml'.freeze
  # FILENAMENOTEXIST = 'aadsasdwqd.zxazxasx.'.freeze
  # before(:all) do
  #   File.open(FILENAME, 'w+')
  # end
  # let(:storage) do
  #   described_class.new(FILENAME)
  # end
  # let(:storage_not_existing) do
  #   described_class.new(FILENAMENOTEXIST)
  # end
  # let(:data) do
  #   Route.new('A', 'B')
  # end
  # after(:all) do
  #   File.delete(FILENAME)
  # end
  #
  # context 'when data is passed for saving' do
  #   it 'stores data into file YAML format' do
  #     storage.save_data(data)
  #     loaded_data = File.read(FILENAME)
  #     loaded_data = YAML.load loaded_data
  #     expect(loaded_data).to eq(data)
  #   end
  # end
  #
  # context 'when file with data is passed' do
  #   it 'reads the data from YAML file' do
  #     data_yaml = YAML.dump data
  #     File.open(FILENAME, 'w+') { |file| file.write(data_yaml) }
  #     expect(storage.load_data).to eq(data)
  #   end
  # end
  #
  # context 'when not existing file is passed' do
  #   it 'raises error' do
  #     expect { storage_not_existing.load_data }.to raise_error(ArgumentError)
  #   end
  # end
end
