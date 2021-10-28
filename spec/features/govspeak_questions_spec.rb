RSpec.feature 'Govspeak questions are rendered correctly' do
  scenario "it correctly renders the yes, no, don't know question" do
    id = 'yes_no_dont_know_question'
    guide_repository = GuideRepository.new(:en, File.expand_path('../../fixtures', __FILE__))
    descorated_guide = GuideDecorator.for(guide_repository.find(id))

    rendered_content = descorated_guide.content

    expect(rendered_content).to include('<h2 id="test-question">Test question</h2>')
    expect(rendered_content).to include('<input type="radio" name="response" id="response_yes" value="yes">')
    expect(rendered_content).to include('<input type="radio" name="response" id="response_no" value="no">')
    expect(rendered_content).to include(
      '<input type="radio" name="response" id="response_dont_know" value="dont_know">'
    )
  end
end
