class MetricChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:name].present?
    Rails.logger.info 'subcribed ... '
    Rails.logger.info "The name is: #{params[:name]}"
    stream_from "metric_channel_#{params[:name]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
