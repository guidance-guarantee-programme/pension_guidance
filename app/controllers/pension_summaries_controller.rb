# rubocop:disable Metrics/ClassLength
class PensionSummariesController < ApplicationController
  include Embeddable

  helper MoneyHelper

  before_action :set_pilot_cookie, if: :pilot_enabled?, only: %i[start]
  before_action :create_summary, only: %i[start]
  before_action :set_summary, except: %i[start save_welsh_summary]
  before_action :show_summary, if: :generated?, only: %i[step_one step_two]
  before_action :set_current_step, only: %i[summary]
  before_action :set_breadcrumbs
  before_action :skip_about_you, unless: :pilot_data_collection?, only: %i[about_you save_about_you]

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to explore_your_options_root_url
  end

  def save_welsh_summary
    @summary = PensionSummary.generate_welsh_digital!(welsh_secondary_params)

    redirect_to explore_your_options_download_url(id: @summary.id, urn: welsh_secondary_params[:urn])
  end

  def start
    if pilot_summaries?
      redirect_to explore_your_options_about_you_url(id: @summary.id)
    else
      redirect_to explore_your_options_step_one_url(id: @summary.id)
    end
  end

  def about_you
    @guide = get_guide('about-you')
  end

  def save_about_you
    @guide = get_guide('about-you')

    if @summary.update(about_you_params)
      redirect_to explore_your_options_step_one_url(id: @summary.id)
    else
      render :about_you
    end
  end

  def step_one
    @guide = get_guide('step-one')
  end

  def save_primary_options
    if @summary.update(primary_params)
      redirect_to explore_your_options_step_two_url(id: @summary.id)
    else
      render :step_one
    end
  end

  def step_two
    @guide = get_guide('step-two')
  end

  def save_secondary_options
    if @summary.generate(secondary_params)
      redirect_to explore_your_options_summary_url(id: @summary.id)
    else
      render :step_two
    end
  end

  def summary
    @guide = get_guide(@summary.current_step)
  end

  def your_experience
    @summary.current_step = 'your_experience'
    @guide = get_guide('your-experience')
  end

  def save_feedback
    @guide = get_guide('your-experience')

    if @summary.submit(feedback_params)
      redirect_to explore_your_options_thank_you_url(id: @summary.id)
    else
      render :your_experience
    end
  end

  def thank_you
    @summary.current_step = 'thank_you'
    @guide = get_guide('thank-you')
  end

  def print
    @intro  = get_guide('print-introduction')
    @outro  = get_guide('trusted-sources', prefixed: false)
    @guides = @summary.selected_steps.collect { |s| get_guide(s) }

    render 'pension_summaries/print', layout: false
  end

  def download
    @intro  = get_guide('print-introduction')
    @outro  = get_guide('trusted-sources', prefixed: false)
    @urn    = params[:urn] if AppointmentSummary::URN_FORMAT_REGEX === params[:urn]
    @guides = @summary.selected_steps.collect { |s| get_guide(s) }

    render pdf: 'Pension Wise Summary',
           template: 'pension_summaries/print',
           handlers: :erb,
           formats: :html,
           layout: false,
           disposition: 'attachment'
  end

  private

  def get_guide(slug, prefixed: true)
    path = prefixed ? "pension_summary/#{slug}" : slug

    GuideDecorator.cached_for(GuideRepository.new.find(path))
  end

  def about_you_params
    params
      .fetch(:pension_summary, {})
      .permit(:consent_given, :name, :email, :age, :gender, :country)
  end

  def primary_params
    params
      .fetch(:pension_summary, {})
      .permit(*PensionSummary::PRIMARY_OPTIONS)
  end

  def secondary_params
    params
      .fetch(:pension_summary, {})
      .permit(*PensionSummary::SECONDARY_OPTIONS)
  end

  def welsh_secondary_params
    params
      .fetch(:appointment_summary, {})
      .permit(
        :supplementary_benefits,
        :supplementary_debt,
        :supplementary_ill_health,
        :supplementary_defined_benefit_pensions,
        :supplementary_pension_transfers,
        :urn
      )
  end

  def feedback_params
    params
      .fetch(:pension_summary, {})
      .permit(:satisfaction, :comments, :where_you_heard)
  end

  def summary_id
    params[:id]
  end

  def create_summary
    @summary = PensionSummary.create!(pilot: pilot_summaries?)
  end

  def set_summary
    if summary_id.present?
      @summary = PensionSummary.find(summary_id)
    else
      redirect_to explore_your_options_root_url
    end
  end

  def show_summary
    redirect_to explore_your_options_summary_url(id: @summary.id)
  end

  def generated?
    @summary.generated?
  end

  def set_current_step
    @summary.current_step = params[:step]
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.build_your_pensions_summary if params[:action] != 'start'
    breadcrumb Breadcrumb.explore_your_options_step_one if %w[start step_one].exclude?(params[:action])
  end

  def pilot_enabled?
    ENV['PILOT_SUMMARIES'] == 'true'
  end

  def set_pilot_cookie
    return if pilot_cookie?

    cookies.permanent[:pilot_summaries] = \
      if params[:locale] == 'cy'
        'false'
      else
        rand > pilot_ratio ? 'true' : 'false'
      end
  end

  def pilot_ratio
    ENV.fetch('PILOT_RATIO', '0.5').to_f
  end

  def pilot_cookie?
    cookies[:pilot_summaries].present?
  end

  def pilot_summaries?
    force_pilot_summaries? || pilot_enabled? && cookies[:pilot_summaries] == 'true'
  end
  helper_method :pilot_summaries?

  def force_pilot_summaries?
    ENV['FORCE_PILOT_SUMMARIES'] == 'true' && params[:locale] == 'en'
  end

  def pilot_data_collection?
    ENV['PILOT_DATA_COLLECTION'] == 'true'
  end

  def skip_about_you
    redirect_to explore_your_options_step_one_url(id: @summary.id)
  end

  def alternate_url(new_locale, options = {})
    url_for(params.permit(:id, :step).merge(options).merge(locale: new_locale))
  end

  def content_lang_matches_locale?
    true
  end

  def skip_to_step_path(step)
    explore_your_options_summary_path(id: @summary.id, step: step)
  end
  helper_method :skip_to_step_path

  def print_summary_path
    explore_your_options_print_path(id: @summary.id)
  end
  helper_method :print_summary_path

  def download_summary_path
    explore_your_options_download_path(id: @summary.id)
  end
  helper_method :download_summary_path
end
# rubocop:enable Metrics/ClassLength
