# tender storage controller
class TenderStorageController < ActionController::Base
  attr_reader :tenders, :last_id, :storage

  def initialize(storage)
    @tenders = []
    @storage = storage
    data_from_storage = storage.load_data
    @tenders = data_from_storage if data_from_storage
    @last_id = 0
    @last_id = tenders.last.id + 1 if tenders.any?
  end

  def add_new(tender)
    tender.give_identity(@last_id)
    tenders.push(tender)
    save_data
    @last_id += 1
  end

  def save_data
    storage.save_data(tenders)
  end

  def remove_by_id(id)
    tenders.delete_if { |tend| tend.id.equal?(id) }
    save_data
    @last_id = 0 if tenders
    @last_id = tenders.last.id + 1 if tenders.any?
  end

  def update(tender)
    remove_by_id(tender.id)
    add_new(tender)
  end
end
