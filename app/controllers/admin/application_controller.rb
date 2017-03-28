class Admin::ApplicationController < ApplicationController
  private

  def basic_authorization
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV['ADMIN_ID'] && pass == ENV['ADMIN_PASS']
    end
  end
end
