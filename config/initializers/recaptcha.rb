Recaptcha.configure do |config|
  # default to test keys that always pass
  config.site_key   = ENV.fetch('RECAPTCHA_SITE_KEY') { '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI' }
  config.secret_key = ENV.fetch('RECAPTCHA_SECRET_KEY') { '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe' }
end
