# tender storage controller
class TenderStorageController
  attr_reader :tenders

  def initialize(storage)
    @tenders = []
  end
end
