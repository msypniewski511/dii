module DeviseSupport
  def login_user(user = nil)
    user ||= FactoryBot.create(:user) # Create a default user if none is provided
    login_as(user, scope: :user)
    user
  end
end

RSpec.configure do |config|
  config.include DeviseSupport, type: :feature
end