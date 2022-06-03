ActiveSupport::Notifications.subscribe 'average_per_minute.event' do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  metric_channel = "metric_channel_#{event.payload[:name].sub('_PM', '')}"
  ActionCable.server.broadcast(metric_channel, event.payload)
end
