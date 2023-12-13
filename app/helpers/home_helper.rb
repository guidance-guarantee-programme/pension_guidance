require 'csv'

module HomeHelper
  BANNER_OVERRIDE = %w(apples paint peppers).freeze
  BANNER_DATE = /\A\d{4}-\d{2}-\d{2}\z/

  BANNER_SCHEDULE = <<~CSV.freeze
    2019-02-17,peppers
    2019-03-02,apples
    2019-12-31,paint
  CSV

  class BannerSchedule
    attr_reader :schedule, :current_date

    delegate :last, to: :schedule

    class << self
      def current(schedule, current_date)
        new(schedule, current_date).current
      end
    end

    def initialize(schedule, current_date)
      @schedule = schedule
      @current_date = current_date
    end

    def current
      schedule.detect(method(:last)) { |row| row.first > current_date }.last
    end
  end

  def banner_image(today = banner_date)
    if banner_image_override?
      banner_image_override
    else
      scheduled_banner_image(today)
    end
  end

  private

  def banner_date_override?
    params.key?(:banner_date) && params[:banner_date].match?(BANNER_DATE)
  end

  def banner_date_override
    Date.iso8601(params[:banner_date].to_s)
  end

  def banner_date
    banner_date_override? ? banner_date_override : Date.current
  end

  def banner_image_override?
    params[:banner].in?(BANNER_OVERRIDE)
  end

  def banner_image_override
    params[:banner]
  end

  def banner_image_schedule
    CSV.parse(ENV.fetch('BANNER_SCHEDULE', BANNER_SCHEDULE), converters: [:date])
  end

  def scheduled_banner_image(today)
    BannerSchedule.current(banner_image_schedule, today)
  end
end
