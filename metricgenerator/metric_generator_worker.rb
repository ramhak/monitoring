require 'sidekiq'
require 'sidekiq-scheduler'
require 'waterdrop'
require 'httpx'
require 'securerandom'

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

class MetricGeneratorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  @@producer = WaterDrop::Producer.new do |config|
    config.deliver = true
    config.kafka = {
      'bootstrap.servers': 'localhost:9092',
      'request.required.acks': 1
    }
  end
  def perform
    response = HTTPX.with(timeout: { connect_timeout: 4, operation_timeout: 4 }).get('https://api.kucoin.com/api/v1/prices?currencies=BTC,ETH')
    data =     response.json['data']
    btc_metric = {
      name: 'BTC',
      value: data['BTC'],
      # value: rand(26_000.00..27_000.00),
      timestamp: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
      uid: SecureRandom.uuid
    }
    eth_metric = {
      name: 'ETH',
      value: data['ETH'],
      timestamp: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
      uid: SecureRandom.uuid
    }
    @@producer.produce_many_sync(
      [
        { topic: 'metrics', payload: btc_metric.to_json, key: 'BTC' }
        { topic: 'metrics', payload: eth_metric.to_json, key: 'ETH' }
      ]
    )
  end
end
