require 'rails_helper'

RSpec.describe "entrepreneurial_skills_user_responses/index", type: :view do
  before(:each) do
    assign(:entrepreneurial_skills_user_responses, [
      EntrepreneurialSkillsUserResponse.create!(
        user: nil,
        question: nil,
        answer: nil
      ),
      EntrepreneurialSkillsUserResponse.create!(
        user: nil,
        question: nil,
        answer: nil
      )
    ])
  end

  it "renders a list of entrepreneurial_skills_user_responses" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
