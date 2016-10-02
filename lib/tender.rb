require 'proposal'
# Tender class
class Tender
  max_proposals_count = 6

  attr_reader :type, :name, :location_to, :location_from,
              :deadline, :proposals

  def initialize(type, name, location_from, location_to, deadline)
    @type = type
    @name = name
    @location_from = location_from
    @location_to = location_to
    @deadline = deadline
    @proposals = []
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
    proposals.push(proposal)
  end
end
