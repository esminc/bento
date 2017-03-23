module BasicAuthHelper

  def user_login
    user_name = ENV['USER_ID']
    password = ENV['USER_PASS']

    basic = ActionController::HttpAuthentication::Basic
    credentials = basic.encode_credentials(user_name, password)
    page.driver.header('Authorization', credentials)
  end

  def admin_login
    user_name = ENV['ADMIN_ID']
    password = ENV['ADMIN_PASS']

    basic = ActionController::HttpAuthentication::Basic
    credentials = basic.encode_credentials(user_name, password)
    page.driver.header('Authorization', credentials)
  end

end
