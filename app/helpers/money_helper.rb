module MoneyHelper
  def money_helper_url(path, locale: :en)
    prefix = ENV.fetch('MONEY_HELPER_CONTENT_PREFIX') { 'https://moneypensions-stage.adobemsbasic.com' }

    "#{prefix}/#{locale}/#{path}"
  end
end
