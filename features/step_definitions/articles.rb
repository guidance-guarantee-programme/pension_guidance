When(/^an article written in govspeak is added$/) do
  @article = Pages::Article.new
  @article.load(id: 'your-pension-pot-value')
end

Then(/^the article appears on the website$/) do
  expect(@article).to be_displayed
end
