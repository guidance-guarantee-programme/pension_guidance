require 'rspec/matchers'

RSpec::Matchers.define :have_meta do |name, expected|
  match do |actual|
    actual.has_css?("meta[name=#{name.to_s.inspect}][content=#{expected.to_s.inspect}]", visible: false)
  end

  failure_message do |actual|
    actual = first("meta[name='#{name}']", visible: false)
    if actual
      "expected that meta #{name} would have content=\"#{expected}\" but was \"{actual[:content]}\""
    else
      "expected that meta #{name} would exist with content=\"#{expected}\""
    end
  end
end
