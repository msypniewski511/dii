class ApplicationController < ActionController::Base
  helper_method :aside_menu
  def aside_menu
    @parts = [
      ["Marketing—Sales and Customer Service", "/", "fas fa-handshake", ["a", ""]],
      ["Personal Character & Skills Analysis", "/home/personal", "fas fa-brain", ["home", "pswot_analyses"]],
      ["Personal Survival Budget (PSB)", "/", "fas fa-file-invoice-dollar", ["a", ""]],
      ["Cashflow Forecast", "/", "fas fa-briefcase", ["a", ""]],
      ["Make It Happen", "/", "fas fa-home", ["a", ""]]
    ]
  end
end
