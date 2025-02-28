class EntrepreneurialSkillsUserResponsesController < ApplicationController
  before_action :set_entrepreneurial_skills_user_response, only: %i[ show edit update destroy ]

  # GET /entrepreneurial_skills_user_responses or /entrepreneurial_skills_user_responses.json
  def index
    @entrepreneurial_skills_user_responses = EntrepreneurialSkillsUserResponse.all
  end

  # GET /entrepreneurial_skills_user_responses/1 or /entrepreneurial_skills_user_responses/1.json
  def show
  end

  # GET /entrepreneurial_skills_user_responses/new
  def new
    @entrepreneurial_skills_user_response = EntrepreneurialSkillsUserResponse.new
  end

  # GET /entrepreneurial_skills_user_responses/1/edit
  def edit
  end

  # POST /entrepreneurial_skills_user_responses or /entrepreneurial_skills_user_responses.json
  def create
    @entrepreneurial_skills_user_response = EntrepreneurialSkillsUserResponse.new(entrepreneurial_skills_user_response_params)

    respond_to do |format|
      if @entrepreneurial_skills_user_response.save
        format.html { redirect_to @entrepreneurial_skills_user_response, notice: "Entrepreneurial skills user response was successfully created." }
        format.json { render :show, status: :created, location: @entrepreneurial_skills_user_response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entrepreneurial_skills_user_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entrepreneurial_skills_user_responses/1 or /entrepreneurial_skills_user_responses/1.json
  def update
    respond_to do |format|
      if @entrepreneurial_skills_user_response.update(entrepreneurial_skills_user_response_params)
        format.html { redirect_to @entrepreneurial_skills_user_response, notice: "Entrepreneurial skills user response was successfully updated." }
        format.json { render :show, status: :ok, location: @entrepreneurial_skills_user_response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entrepreneurial_skills_user_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entrepreneurial_skills_user_responses/1 or /entrepreneurial_skills_user_responses/1.json
  def destroy
    @entrepreneurial_skills_user_response.destroy!

    respond_to do |format|
      format.html { redirect_to entrepreneurial_skills_user_responses_path, status: :see_other, notice: "Entrepreneurial skills user response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entrepreneurial_skills_user_response
      @entrepreneurial_skills_user_response = EntrepreneurialSkillsUserResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entrepreneurial_skills_user_response_params
      params.require(:entrepreneurial_skills_user_response).permit(:user_id, :question_id, :answer_id, :time)
    end
end
