# Company module
class Company < ActiveRecord::Base
  attr_reader :name
  def initialize(name)
    @name = name
  end
end
