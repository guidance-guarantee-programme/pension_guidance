class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def next
    question = GuideDecorator.cached_for(GuideRepository.new.find(params[:question_id]))
    answer = question.metadata.answers[params[:response]]

    redirect_to answer || "/#{params[:question_id]}"
  end
end
