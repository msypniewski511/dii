class IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_idea, only: %i[ show edit update destroy ]

  # GET /ideas or /ideas.json
  def index
    @ideas = current_user.ideas
  end

  # GET /ideas/1 or /ideas/1.json
  def show
  end

  # GET /ideas/new
  def new
    @idea = current_user.ideas.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas or /ideas.json
  def create
    @idea = current_user.ideas.new(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: "Idea was successfully created." }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1 or /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: "Idea was successfully updated." }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1 or /ideas/1.json
  def destroy
    @idea.destroy!

    respond_to do |format|
      format.html { redirect_to ideas_path, status: :see_other, notice: "Idea was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = current_user.ideas.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The idea you are looking for could not be found."
      redirect_to ideas_path
    end
    

    # Only allow a list of trusted parameters through.
    def idea_params
      params.require(:idea).permit(:due_date, :priority, :action_point, :status, :added_to_business_plan)
    end
end
