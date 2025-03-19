class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  self.abstract_class = true

  def calculate_progress(fields)
    return 0 if self.nil?

    total_fields = fields.size
    completed_fields = fields.count { |field| self[field].present? }

    (completed_fields.to_f / total_fields * 100).round
  end
end
