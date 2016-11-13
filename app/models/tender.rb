require_relative 'proposal'
require_relative 'shipment_tender_datum'
require_relative 'proposals_datum'
# Tender class
class Tender < ActiveRecord::Base
  attr_reader :shipment_tender_data, :proposals_data, :id
  has_one :shipment_tender_data
  has_one :proposals_data

  def initialize(shipment_tender_data, proposals_data)
    @shipment_tender_data = shipment_tender_data
    @proposals_data = proposals_data
    @id = -1
  end

  def give_identity(identity)
    @id = identity if id.equal?(-1)
  end

  def edit(shipment_tender_data)
    @shipment_tender_data = shipment_tender_data
    proposals_data
      .tender_data_changed { |prop| puts "Email sent to: #{prop.user.email}" }
  end

  def to_s
    "Id: #{id}, Type: #{shipment_tender_data.type}, " \
    "Name: #{shipment_tender_data.name}, " \
    "Proposals count: #{proposals_data.proposals.length}"
  end
end
