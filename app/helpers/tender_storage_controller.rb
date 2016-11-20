# tender storage controller
class TenderStorageController
  attr_reader :storage_type_class

  def initialize(type)
    @storage_type_class = type
  end

  def tenders
    @storage_type_class.all
  end

  def tender(search_value)
    @storage_type_class.find_by(id: search_value) if search_value
                                                     .is_a? Numeric
  end

  def add_new(tender_data, proposals_data)
    tender = @storage_type_class.new(shipment_tender_datum: tender_data,
                                     proposals_datum: proposals_data)
    tender.save
  end

  # @storage_type_class.joins(:shipment_tender_datum)
  # .where(shipment_tender_data: {name: search_value}).limit(1)
end
