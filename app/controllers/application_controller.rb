class ApplicationController < ActionController::Base
  helper_method :aside_menu
  def aside_menu
    @parts = [["Marketing—Sales and Customer Service", "/"],
    ["Personal Character & Skills Analysis", "/"],
    ["Personal Survival Budget (PSB)", "/"],
    ["Cashflow Forecast", "/"],
    ["Make It Happen", "/"]]
  end
end
