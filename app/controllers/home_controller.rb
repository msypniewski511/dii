class HomeController < ApplicationController
  before_action :authenticate_user!, only: :dashboard
  def index
    render layout: "landing"
  end

  def dashboard
  end
end
