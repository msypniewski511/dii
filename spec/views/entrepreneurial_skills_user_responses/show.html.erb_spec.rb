require 'rails_helper'

RSpec.describe "entrepreneurial_skills_user_responses/show", type: :view do
  before(:each) do
    assign(:entrepreneurial_skills_user_response, EntrepreneurialSkillsUserResponse.create!(
      user: nil,
      question: nil,
      answer: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
