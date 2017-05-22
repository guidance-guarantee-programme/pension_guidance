# Reset the locale after each scenario to ensure
# all tests start with the expected default locale.
After do
  I18n.locale = :en
end
