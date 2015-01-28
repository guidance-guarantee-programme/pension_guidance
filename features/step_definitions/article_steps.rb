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

When(/^I add an article written in govspeak$/) do
  @article = Pages::Article.new
  @article.load(id: File.basename(@file, '.md').tr('_', '-'))
end

Then(/^the article appears on the website$/) do
  expect(@article).to be_displayed
end

Then(/^the page title corresponds to the title of the article$/) do
  expect(@article.title).to include 'Think about your pension'
end
