# rubocop:disable Metrics/ClassLength
class PensionSummariesController < ApplicationController
  layout 'guides'

  before_action :create_summary, only: %i(create)
  before_action :set_summary, except: %i(start create)
  before_action :show_summary, if: :generated?, only: %i(step_one step_two)
  before_action :set_current_step, only: %i(summary)
  before_action :set_breadcrumbs

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to explore_your_options_root_url
  end

  def start
    @guide = get_guide('start')
  end

  def create
    redirect_to explore_your_options_step_one_url(id: @summary.id)
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
    if @summary.update(secondary_params)
      @summary.generate
      redirect_to explore_your_options_summary_url(id: @summary.id)
    else
      render :step_two
    end
  end

  def summary
    @guide = get_guide(@summary.current_step)
  end

  def print
    @intro = get_guide('print-introduction')
    @guides = @summary.selected_steps.collect { |s| get_guide(s) }

    render 'pension_summaries/print', layout: false
  end

  def download
    @intro = get_guide('print-introduction')
    @guides = @summary.selected_steps.collect { |s| get_guide(s) }

    render pdf: 'your pension summary from Pension Wise',
           template: 'pension_summaries/print',
           handlers: %w(erb),
           formats: %w(html),
           layout: false,
           disposition: 'inline'
  end

  private

  def get_guide(slug)
    GuideDecorator.cached_for(GuideRepository.new.find("pension_summary/#{slug}"))
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

  def summary_id
    params[:id]
  end

  def create_summary
    @summary = PensionSummary.create!
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
    breadcrumb Breadcrumb.explore_your_options_step_one if %w(start step_one).exclude?(params[:action])
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
