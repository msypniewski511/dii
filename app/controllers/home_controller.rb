class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard, :personal]
  def index
    render layout: "landing"
  end

  def dashboard
  end

  def personal
    @swot = current_user.pswot_analyses.last
    @assessment = current_user.assessments.last
    Rails.logger.debug "Raw ai_insights: #{@assessment.ai_insights.inspect}"
    @ai_insights = @assessment.ai_insights
  end
end
