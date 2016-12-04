# Proposals controller
class ProposalController < ApplicationController
  helper_method :params

  def show
    @proposals = Proposal.all
  end

  def new
  end

  def create
    proposal_params = read_proposal_params
    proposal = Proposal.new(user_id: proposal_params[:user_id],
                            price: proposal_params[:price],
                            proposals_datum_id: params[:tender_id])

    proposal.save

    redirect_to proposal
  end

  def read_proposal_params
    params[:proposal]
  end
end
