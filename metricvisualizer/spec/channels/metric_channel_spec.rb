require 'rails_helper'

RSpec.describe MetricChannel, type: :channel do
  it 'successfuly subscribes' do
    subscribe name: 'test'
    expect(subscription).to be_confirmed
  end
  it 'reject subscription' do
    subscribe name: nil
    expect(subscription).to be_rejected
  end
end
