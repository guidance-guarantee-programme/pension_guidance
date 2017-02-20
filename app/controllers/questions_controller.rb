# rubocop:disable Metrics/AbcSize, Lint/AssignmentInCondition
class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def next
    question = GuideDecorator.cached_for(GuideRepository.new.find(params[:question_id]))

    if answer = question.metadata.answers[params[:response]]
      redirect_to answer
    else
      redirect_to "/#{params[:question_id]}", alert: I18n.t('pension_type_tool.error')
    end
  end
end
