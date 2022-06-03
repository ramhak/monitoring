class MetricPersisterConsumer < ApplicationConsumer
  def consume
    Metric.save_all(params_batch.payloads.map { |m| m.transform_keys('timestamp' => 'created_at') })
  end
end
