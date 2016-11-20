require_relative 'proposal'
# Proposals data class
class ProposalsDatum < ApplicationRecord
  has_many :proposals
  has_one :proposal
  belongs_to :tender

  def add_proposal(proposal)
    return false unless can_proposal_be_added(proposal)
    proposals.push(proposal)
    true
  end

  def can_proposal_be_added(proposal)
    return if count_days_to_deadline < 0
    return if proposals.length.equal?(max_proposals_count)
    return if proposals
              .select do |prop|
                prop.user.company.equal?(proposal.user.company)
              end
              .any?
    true
  end

  def select_winner(company_name)
    found_winner_proposal = proposals
                            .find do |prop|
      prop.user.company.name.equal?(company_name)
    end
    raise ArgumentError, 'Not existing' unless found_winner_proposal
    self.winner_proposal_id = found_winner_proposal.id
  end

  def count_days_to_deadline
    deadline - Date.today
  end

  def tender_data_changed
    proposals.each { |prop| yield prop }
    proposals.clear
  end
end
