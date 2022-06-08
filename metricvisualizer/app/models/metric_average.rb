class MetricAverage
  attr_reader :id, :average_data

  def initialize(id:, average_data:)
    @id = id
    @average_data = average_data
  end

  def self.find(id)
    json = Kredis.json id
    json.value = { sum: 0, count: 0, first_time_in_current_window: nil } unless json.value.present?
    MetricAverage.new id:, average_data: json
  end

  def caclulate_average(value:, timestamp:)
    average_data = @average_data.value
    metric_time = timestamp.to_time
    unless average_data['first_time_in_current_window'].present?
      average_data['first_time_in_current_window'] = metric_time
    end
    delta = TimeDifference.between(average_data['first_time_in_current_window'], metric_time).in_minutes.floor
    average = 0
    if delta == 1
      average =  average_data['sum'] / average_data['count']
      average_data['sum'] = 0
      average_data['count'] = 0
      average_data['first_time_in_current_window'] = nil
    elsif delta > 1
      # it means we miss this window
      average_data['first_time_in_current_window'] = metric_time
      average_data['sum'] = 0
      average_data['count'] = 0
    else
      average_data['count'] += 1
      average_data['sum'] += value.to_f
    end
    @average_data.value = average_data
    if average.positive?
      ActiveSupport::Notifications.instrument 'average_per_minute.event',
                                              { name: "#{id}_PM", value: average,
                                                timestamp: metric_time.strftime('%Y-%m-%dT%H:%M:%S.%LZ') }
    end
  end
end
