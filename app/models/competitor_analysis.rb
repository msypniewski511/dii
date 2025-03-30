class CompetitorAnalysis < ApplicationRecord
  belongs_to :business_idea
  has_many :competitors, dependent: :destroy

  validates :business_idea, presence: true

  after_save :update_stage_status
  after_update :update_stage_status

  def progress_percentage
    return 0 if competitors.empty?
    total = competitors.count
    completed = competitors.select { |c| c.five_forces.present? }.count
    ((completed.to_f / total) * 100).round
  end

  def completed?
    progress_percentage == 100
  end

  def country
    business_idea.country
  end

  def update_stage_status
    stage = business_idea.stages.find_by(name: "Competitor Analysis", stage_type: "nine_stages")
    return unless stage
    stage.update(
      progress_percentage: progress_percentage,
      status: completed? ? :completed : :in_progress
    )
  end
end
