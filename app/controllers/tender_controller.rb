require_relative '../models/tender'
# Tenders controller main
class TenderController < ApplicationController
  def initialize
    @tender_params = {}
  end

  def index
  end

  def show
    @tenders = Tender.all
  end

  def new
  end

  def create
    data = create_tender_datum
    tender = create_tender data

    tender.save
    redirect_to tender
  end

  def create_tender_datum
    @tender_params = read_tender_params
    ShipmentTenderDatum.new(shipment_type: @tender_params[:type],
                            name:
                                @tender_params[:cargo_name],
                            route: create_route)
  end

  def read_tender_params
    params[:tender]
  end

  def create_tender(data)
    tender_params = read_tender_params
    deadline_date = DateTime.parse(tender_params[:deadline]).to_date
    proposals_data = ProposalsDatum.new(deadline: deadline_date)
    Tender.new(shipment_tender_datum: data, proposals_datum: proposals_data)
  end

  def create_route
    route_from = @tender_params[:route_from]
    route_to = @tender_params[:route_to]
    route = Route.new(source: route_from, destination: route_to)
    route
  end
end
