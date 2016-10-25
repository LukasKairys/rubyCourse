require_relative 'proposal'
require_relative 'shipmenttenderdata'
require_relative 'proposalsdata'
# Tender class
class Tender
  attr_reader :shipment_tender_data, :proposals_data, :id

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
