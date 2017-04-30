module Idobata
  def post(message, url)
    Faraday.post(url, source: message, format: 'html') if url.present?
  end

  module_function :post
end
