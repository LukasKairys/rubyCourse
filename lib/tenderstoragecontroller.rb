# tender storage controller
class TenderStorageController
  attr_reader :tenders

  def initialize(storage)
    @tenders = []
  end

  def add_new(tender)
    tenders.push(tender)
  end

  def update(tender)
    @tenders.delete_if { |tend| tend.id == tender.id }
    @tenders.push(tender)
  end
end
