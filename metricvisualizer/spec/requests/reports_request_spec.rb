require 'rails_helper'
RSpec.describe 'Reports', type: :request do
  context 'when there is no metric' do
    it 'should return empty array' do
      get '/api/v1/reports/test?start=2022-01-01'
      expect(json.size).to eq 0
    end
  end
  context 'when there are some metrics' do
    before do
      travel_to Time.new(2022, 1, 1, 10, 15, 30)
      create_list :metric, 4
      travel_back
      get '/api/v1/reports/test?start=2022-01-01'
    end
    it 'the request should completed successfuly' do
      expect(response).to have_http_status(:success)
    end
    it 'the items should be sorted by date' do
      result = json.each_cons(2).all? { |m1, m2| Time.parse(m1['created_at']) > Time.parse(m2['created_at']) }
      expect(result).to be true
    end
    it 'the number of items should be same as the metrics numbers' do
      expect(json.size).to eq 4
    end
  end
end
