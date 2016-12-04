require 'rails_helper'

RSpec.describe 'proposal/show.html.erb', type: :view do
  fixtures :all

  let(:proposal_one) do
    proposals(:proposal_one)
  end

  it 'displays all the tenders' do
    assign(:proposals,
           [proposal_one])

    render

    expect(rendered)
      .to match(/#{proposal_one.user.email}|
                #{proposal_one.price}|
                #{proposal_one.proposals_datum_id}/)
  end
end
