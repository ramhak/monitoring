module Api
  module V1
    class ReportsController < ApplicationController
      def index
        render json: MetricReport.find_by_name_and_date(metric_params(params))
      end

      private

      def metric_params(params)
        Rails.logger.info params
        params.require(:name)
        params.require(:start)
        Rails.logger.info params
        params = params.merge({ start: DateTime.parse(params[:start]) })
        params = if params.include?(:end)
                   params.merge({ end: DateTime.parse(params[:end]) })
                 else
                   params.merge({ end: DateTime.now })
                 end
        params = params.permit(:name, :start, :end)
        params.to_h
      end
    end
  end
end
