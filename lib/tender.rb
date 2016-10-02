require 'proposal'
# Tender class
class Tender
  attr_reader :type, :name, :location_to, :location_from,
              :deadline, :proposals, :max_proposals_count

  def initialize(type, name, location_from, location_to, deadline)
    @type = type
    @name = name
    @location_from = location_from
    @location_to = location_to
    @deadline = deadline
    @proposals = []
    @max_proposals_count = 6
  end

  def count_days_to_deadline
    days_to_deadline = @deadline - Date.today
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

    same_prop = proposals
                .select { |prop| prop.company_name == proposal.company_name }

    return false if same_prop.any?
    true
  end

  def edit(type, name, location_from, location_to, deadline)
    @type = type
    @name = name
    @location_from = location_from
    @location_to = location_to
    @deadline = deadline

    return if @proposals.empty?

    @proposals.each { |prop| yield prop }
    @proposals.clear
  end
end
