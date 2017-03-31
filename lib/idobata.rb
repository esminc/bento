module Idobata
  def post(message)
    url = ENV['IDOBATA_HOOK_URL']
    Faraday.post(url, source: message, format: 'html') if url.present?
  end

  module_function :post
end
