require_relative '../lib/DataStorage'
require_relative '../lib/Tender'
require_relative '../lib/ShipmentTenderData'
require_relative '../lib/Route'
require_relative '../lib/TenderStorageController'
# Main ui controller
class UIController
  attr_reader :tender_storage_controller
  def initialize
    tender_filename = '../data/tender_data.yaml'
    tender_storage = DataStorage.new(tender_filename)
    @tender_storage_controller = TenderStorageController.new(tender_storage)
  end

  def initialize_menu
    selection = 1
    while selection > 0
      system 'clear'
      puts '1. Create tender'
      puts '2. Add proposal to tender'
      puts '3. Delete tender'
      puts '4. View all tenders'
      puts '0. Exit'
      selection = process_menu
    end
  end

  def process_menu
    selection = gets.chomp.to_i
    system 'clear'
    case selection
    when 1
      create_tender
    when 2
      puts '2'
    when 3
      delete_tender
    when 4
      display_all_tenders
    else
      system 'exit'
    end
    selection
  end

  def delete_tender
    puts 'Id'
    id = gets.chomp.to_i
    @tender_storage_controller.remove_by_id(id)
  end

  def display_all_tenders
    puts 'Tenders:'
    puts @tender_storage_controller.tenders
    puts ''
    puts '--Write 0 to go back to meniu'
    gets.chomp
  end

  def create_tender
    puts 'Import or Export'
    type = gets.chomp
    puts 'Cargo name'
    cargo_name = gets.chomp
    puts 'Route from'
    route_a = gets.chomp
    puts 'Route to'
    route_b = gets.chomp
    puts 'Deadline'
    deadline = gets.chomp

    route = Route.new(route_a, route_b)
    tender_data = ShipmentTenderData.new(type, cargo_name, route, deadline)
    tender = Tender.new(@tender_storage_controller.last_id, tender_data)

    @tender_storage_controller.add_new(tender)
  end
end
