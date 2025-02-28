class ApplicationController < ActionController::Base
  helper_method :aside_menu
  def aside_menu
    @parts = [["Marketing—Sales and Customer Service", "/", "fas fa-handshake"],
    ["Personal Character & Skills Analysis", "/", "fas fa-brain"],
    ["Personal Survival Budget (PSB)", "/", "fas fa-file-invoice-dollar"],
    ["Cashflow Forecast", "/", "fas fa-briefcase"],
    ["Make It Happen", "/"]]
  end
end
