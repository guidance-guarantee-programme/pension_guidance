require 'spec_helper'

RSpec.describe QuestionsController, type: :controller do
  subject { post 'next', params: { question_id: 'pension-type-tool/question-1' } }

  it 'correctly redirects back when no answer is provided' do
    expect(subject).to redirect_to('http://test.host/pension-type-tool/question-1')
  end
end
