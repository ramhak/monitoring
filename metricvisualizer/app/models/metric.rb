class Metric < ApplicationRecord
  def self.save_all(metrics)
    insert_all(metrics, unique_by: :uid)
  end
end
