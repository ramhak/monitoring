class MetricBroadcasterConsumer < ApplicationConsumer
  def consume
    Rails.logger.info 'metric broadcaster consumer'
    ActionCable.server.broadcast("metric_channel_#{params.payload['name']}", params.payload)
  end
end
