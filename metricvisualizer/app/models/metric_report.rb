class MetricReport < ApplicationRecord
  self.primary_key = :uid
  def self.find_by_name_and_date(params)
    where(name: params[:name], created_at: (params[:start]..params[:end]))
  end

  def readonly?
    true
  end
end
