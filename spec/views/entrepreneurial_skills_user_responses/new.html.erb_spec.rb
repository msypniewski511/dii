require 'rails_helper'

RSpec.describe "entrepreneurial_skills_user_responses/new", type: :view do
  before(:each) do
    assign(:entrepreneurial_skills_user_response, EntrepreneurialSkillsUserResponse.new(
      user: nil,
      question: nil,
      answer: nil
    ))
  end

  it "renders new entrepreneurial_skills_user_response form" do
    render

    assert_select "form[action=?][method=?]", entrepreneurial_skills_user_responses_path, "post" do

      assert_select "input[name=?]", "entrepreneurial_skills_user_response[user_id]"

      assert_select "input[name=?]", "entrepreneurial_skills_user_response[question_id]"

      assert_select "input[name=?]", "entrepreneurial_skills_user_response[answer_id]"
    end
  end
end
