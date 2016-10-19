require_relative 'proposal'
require_relative 'shipmenttenderdata'
# Tender class
class Tender
  attr_reader :shipment_tender_data, :proposals, :max_proposals_count,
              :id, :winner_proposal

  def initialize(shipment_tender_data)
    @shipment_tender_data = shipment_tender_data
    @proposals = []
    @max_proposals_count = 6
    @id = -1
  end

  def give_identity(id)
    @id = id if @id == -1
  end

  def count_days_to_deadline
    days_to_deadline = @shipment_tender_data.deadline - Date.today
    if days_to_deadline < 0
      -1
    else
      days_to_deadline
    end
  end

  def add_proposal(proposal)
    return false unless can_proposal_be_added(proposal)
    proposals.push(proposal)
    true
  end

  def can_proposal_be_added(proposal)
    return false if count_days_to_deadline < 0
    return false if proposals.length >= max_proposals_count
    return false if proposals
                    .select do |prop|
                      prop.user.company == proposal.user.company
                    end
                    .any?
    true
  end

  def edit(shipment_tender_data)
    @shipment_tender_data = shipment_tender_data

    return if @proposals.empty?

    @proposals.each { |prop| yield prop }
    @proposals.clear
  end

  def select_winner(company_name)
    found_winner_proposal = @proposals
                            .find do |prop|
                              prop.user.company.name == company_name
                            end
    raise ArgumentError, 'Not existing ' unless found_winner_proposal
    @winner_proposal = found_winner_proposal
  end

  def to_s
    "Id: #{@id}, Type: #{@shipment_tender_data.type}, " \
    "Name: #{@shipment_tender_data.name}" \
    "Proposals count: #{proposals.length}"
  end
end
