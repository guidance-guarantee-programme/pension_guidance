require 'spec_helper'

RSpec.describe QuestionsController, type: :controller do
  subject { post 'next', question_id: 'pension_type_tool/question_1' }

  it 'correctly redirects back when no answer is provided' do
    expect(subject).to redirect_to('http://test.host/pension_type_tool/question_1')
  end
end
