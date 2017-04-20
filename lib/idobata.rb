module Idobata
  def post_for_developer(message)
    url = ENV['IDOBATA_DEVELOPER_HOOK_URL']
    Faraday.post(url, source: message, format: 'html') if url.present?
  end

  def post_for_user(message)
    url = ENV['IDOBATA_USER_HOOK_URL']
    Faraday.post(url, source: message, format: 'html') if url.present?
  end

  module_function :post_for_developer, :post_for_user
end
