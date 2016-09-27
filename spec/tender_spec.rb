require 'tender'
describe Tender do
  context 'when deadline is set to today' do
    it 'returns zero' do
      shipment_tender = Tender.new('Import', 'Shoes tender',
                                   'Vilnius', 'Klaipeda', Time.now)
      expect(shipment_tender.days_to_deadline).to eq(0)
    end
  end

  context 'when deadline is set to today' do
    it 'returns zero' do
      shipment_tender = Tender.new('Import', 'Shoes tender',
                                   'Vilnius', 'Klaipeda', Time.now)
      expect(shipment_tender.days_to_deadline).to eq(0)
    end
  end
end
