class CreateMetricReports < ActiveRecord::Migration[7.0]
  def change
    create_view :metric_reports
  end
end
