Before do
  @file = Rails.root.join('content', 'think_about_pension.md')

  File.open(@file, 'w') do |f|
    f.write <<-GOVSPEAK.strip_heredoc
      # Think about your pension

      %It is important%
    GOVSPEAK
  end
end

After do
  File.delete(@file)
end

When(/^I visit the (.*) guide$/) do
  pending
end

When(/^I add a guide written in govspeak$/) do
  @guide = Pages::Guide.new
  @guide.load(id: File.basename(@file, '.md').tr('_', '-'))
end

Then(/^the guide appears on the website$/) do
  expect(@guide).to be_displayed
end

Then(/^the page title corresponds to the title of the guide/) do
  expect(@guide.title).to include 'Think about your pension'
end

Then(/^the guide exists$/) do
  pending
end
