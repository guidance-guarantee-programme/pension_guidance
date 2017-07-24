class PensionSummariesController < ApplicationController
  layout 'guides'

  before_action :set_summary
  before_action :set_breadcrumbs

  def start
    @guide = get_guide('start')
  end

  def step_one
    @guide = get_guide('step-one')
  end

  def step_two
    @guide = get_guide('step-two')
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

  PENSION_SUMMARY_PARAMS = [
    *PensionSummary::OPTIONS,
    :current_step
  ].freeze

  def summary_params
    params
      .fetch(:pension_summary, {})
      .permit(PENSION_SUMMARY_PARAMS)
  end

  def set_summary
    @summary = PensionSummary.new(summary_params)
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.build_your_pensions_summary if params[:action] != 'start'
    breadcrumb Breadcrumb.explore_your_options_step_one if %w(start step_one).exclude?(params[:action])
  end

  def alternate_url(new_locale, options = {})
    new_params = params.permit(:id, :locale, pension_summary: PENSION_SUMMARY_PARAMS)
    new_params.merge!(options)
    new_params[:locale] = new_locale

    url_for(new_params)
  end

  def content_lang_matches_locale?
    true
  end

  def skip_to_step_path(step)
    new_params = summary_params.merge(current_step: step)
    explore_your_options_summary_path(pension_summary: new_params)
  end
  helper_method :skip_to_step_path

  def print_summary_path
    explore_your_options_print_path(pension_summary: summary_params)
  end
  helper_method :print_summary_path

  def download_summary_path
    explore_your_options_download_path(pension_summary: summary_params)
  end
  helper_method :download_summary_path
end
