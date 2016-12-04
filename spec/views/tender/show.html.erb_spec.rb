require 'rails_helper'

RSpec.describe 'tender/show.html.erb', type: :view do
  fixtures :all

  let(:shipment_tender_tomorrow) do
    tenders(:tender_one)
  end

  it 'displays all the tenders' do
    assign(:tenders,
           [shipment_tender_tomorrow])

    render

    expect(rendered).to match shipment_tender_tomorrow.id.to_s
  end
end
