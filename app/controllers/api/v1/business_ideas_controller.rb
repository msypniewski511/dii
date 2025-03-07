class Api::V1::BusinessIdeasController < ApplicationController
  before_action :authenticate_user!

  def index
    business_ideas = current_user.business_ideas
    render json: business_ideas
  end

  def show
    business_idea = current_user.business_ideas.find(params[:id])
    render json: business_idea
  end

  def create
    business_idea = current_user.business_ideas.build(business_idea_params)
    if business_idea.save
      render json: business_idea, status: :created
    else
      render json: { errors: business_idea.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    business_idea = current_user.business_ideas.find(params[:id])
    if business_idea.update(business_idea_params)
      render json: business_idea
    else
      render json: { errors: business_idea.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    business_idea = current_user.business_ideas.find(params[:id])
    business_idea.destroy
    head :no_content
  end

  private

  def business_idea_params
    params.require(:business_idea).permit(:title, :description, :status)
  end
end
