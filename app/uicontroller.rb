require_relative 'models/tender'
require_relative 'models/route'
require_relative 'models/proposal'
require_relative 'models/user'
require_relative 'helpers/tender_storage_controller'
require_relative 'models/company'
require_relative 'models/shipment_tender_datum'
require_relative 'models/proposals_datum'
# Main ui controller
class UIController
  attr_reader :tender_storage_controller
  def initialize
    @tender_storage_controller = TenderStorageController.new
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

  # rubocop:disable MethodLength
  # :reek:TooManyStatements
  def process_menu
    selection = gets.chomp.to_i
    system 'clear'
    case selection
    when 1
      init_tender_creation
    when 2
      add_proposal_step_one
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
    id = read_parameter('Id')
    @tender_storage_controller.remove_by_id(id)
  end

  def add_proposal_step_one
    id = read_parameter('Tender Id')
    add_proposal_step_two(id)
  end

  def add_proposal_step_two(id)
    return unless check_tender_existance(id)

    user = create_user
    price = read_parameter('Price')

    process_proposal_data(id, user, price)
  end

  def process_proposal_data(id, user, price)
    tender = @tender_storage_controller.tender_by_id(id)
    tender.proposals_datum.add_proposal(Proposal.new(user: user, price: price))
  end

  def check_tender_existance(id)
    tender = @tender_storage_controller.tender_by_id(id)
    return unless tender
    puts 'Tender does not exist'
    last_step
  end

  def create_user
    email = read_parameter('Email')
    company = Company.new(name: read_parameter('Company name'))
    user = User.new(email: email, password: 'randomSecurepassword')
    user.assign_company(company)
    user
  end

  def display_all_tenders
    puts 'Tenders:'
    puts @tender_storage_controller.tenders
    last_step
  end

  def init_tender_creation
    tender_data = create_tender_data
    deadline = read_parameter('Deadline')
    create_tender(tender_data, deadline)
  end

  def create_tender_data
    type = read_parameter('Import or Export')
    cargo_name = read_parameter('Cargo name')
    route_a = read_parameter('Route from')
    route_b = read_parameter('Route to')
    ShipmentTenderDatum.new(shipment_type: type, name: cargo_name,
                            route: Route.new(source: route_a,
                                             destination: route_b))
  end

  def read_parameter(text)
    puts text
    gets.chomp
  end

  def create_tender(tender_data, deadline)
    deadline_date = DateTime.parse(deadline).to_date
    proposals_data = ProposalsDatum.new(deadline: deadline_date)
    @tender_storage_controller.add_new(tender_data, proposals_data)
  end

  def last_step
    puts ''
    puts '--Write 0 to go back to meniu'
    gets.chomp
  end
end
