require_relative 'proposal'
require_relative 'shipment_tender_datum'
require_relative 'proposals_datum'
# Tender class
class Tender < ApplicationRecord
  has_one :shipment_tender_datum
  has_one :proposals_datum

  validates_presence_of :shipment_tender_datum, :proposals_datum

  def edit(shipment_tender_data)
    self.shipment_tender_datum = shipment_tender_data
    proposals_datum.tender_data_changed do |prop|
      puts "Email sent to: #{prop.user.email}"
    end if proposals_datum.proposals.any?
  end

  def to_s
    "Id: #{id}, Type: #{shipment_tender_datum.shipment_type}, " \
    "Name: #{shipment_tender_datum.name}, " \
    "Proposals count: #{proposals_datum.proposals.length}"
  end
end
