# tender storage controller
class TenderStorageController
  attr_reader :tenders, :last_id

  def initialize(storage)
    @tenders = []
    @storage = storage
    data_from_storage = storage.load_data
    @tenders = data_from_storage if data_from_storage
    @last_id = 0
    @last_id = @tenders.last.id + 1 if @tenders.any?
  end

  def add_new(tender)
    tenders.push(tender)
    @storage.save_data(@tenders)
    @last_id += 1
  end

  def remove_by_id(id)
    @tenders.delete_if { |tend| tend.id == id }
    @storage.save_data(@tenders)
    # @last_id = 0
  end

  def update(tender)
    remove_by_id(tender.id)
    add_new(tender)
  end
end
