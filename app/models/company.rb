# Company module
class Company < ApplicationRecord
  belongs_to :user
  attr_reader :name

  validates_presence_of :name
  validates_uniqueness_of :name
end
