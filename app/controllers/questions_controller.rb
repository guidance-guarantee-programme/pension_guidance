# rubocop:disable Lint/AssignmentInCondition
class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def next # rubocop:disable Metrics/AbcSize
    question = GuideDecorator.cached_for(GuideRepository.new.find(params[:question_id]))

    if answer = question.metadata.answers[params[:response]]
      redirect_to answer
    else
      redirect_to "/#{I18n.locale}/#{params[:question_id]}", alert: true
    end
  end
end
# rubocop:enable Lint/AssignmentInCondition
