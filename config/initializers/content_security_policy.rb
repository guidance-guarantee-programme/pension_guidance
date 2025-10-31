# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data, 'maps-uk.sc.omtrdc.net'
  policy.connect_src :self, :https, 'moneypensions.tt.omtrdc.net'
  policy.object_src  :none
  policy.style_src   :self, :https, :unsafe_inline

  policy.script_src      :self, :https
  policy.script_src_elem :self, :https, :unsafe_inline
  # Specify URI for violation reports
  policy.report_uri '/csp-reports'
end

# If you are using UJS then enable automatic nonce generation
Rails.application.config.content_security_policy_nonce_generator = ->(_) { SecureRandom.base64(16) }

# Set the nonce only to specific directives
Rails.application.config.content_security_policy_nonce_directives = %w[script-src]
Rails.application.config.content_security_policy_nonce_auto = true

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
Rails.application.config.content_security_policy_report_only = true
