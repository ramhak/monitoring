class MetricAveragePerMinuteConsumer < ApplicationConsumer
  def consume
    metric_average = MetricAverage.find params.payload['name']
    metric_average.caclulate_average value: params.payload['value'], timestamp: params.payload['timestamp']
  end
end
