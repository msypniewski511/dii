require 'rails_helper'

RSpec.describe "entrepreneurial_skills_user_responses/edit", type: :view do
  let(:entrepreneurial_skills_user_response) {
    EntrepreneurialSkillsUserResponse.create!(
      user: nil,
      question: nil,
      answer: nil
    )
  }

  before(:each) do
    assign(:entrepreneurial_skills_user_response, entrepreneurial_skills_user_response)
  end

  it "renders the edit entrepreneurial_skills_user_response form" do
    render

    assert_select "form[action=?][method=?]", entrepreneurial_skills_user_response_path(entrepreneurial_skills_user_response), "post" do

      assert_select "input[name=?]", "entrepreneurial_skills_user_response[user_id]"

      assert_select "input[name=?]", "entrepreneurial_skills_user_response[question_id]"

      assert_select "input[name=?]", "entrepreneurial_skills_user_response[answer_id]"
    end
  end
end
