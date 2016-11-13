require_relative '../models/tender'
require 'yaml'
# JSON tender storage
class DataStorage < ActionController::Base
  def initialize(file_path)
    @file_path = File.expand_path(file_path)
  end

  def save_data(data)
    data_yaml = YAML.dump data
    File.open(@file_path, 'w+') { |file| file.write(data_yaml) }
  end

  def load_data
    raise ArgumentError unless File.file?(@file_path)
    data_yaml = File.read(@file_path)
    YAML.load data_yaml
  end
end