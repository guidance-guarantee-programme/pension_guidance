class PensionTypesController < ApplicationController
  def next
    question = GuideDecorator.cached_for(GuideRepository.new.find(params[:question_id]))
    answer = question.answers[params[:response]]

    redirect_to answer || params[:question_id]
  end
end
