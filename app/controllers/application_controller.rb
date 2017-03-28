class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :basic_authorization

  private

  def basic_authorization
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV['USER_ID'] && pass == ENV['USER_PASS']
    end
  end
end
