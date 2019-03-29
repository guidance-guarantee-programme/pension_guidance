require 'csv'

module MarketingHelper
  CAMPAIGN_OVERRIDE = %w(dogs apples paint peppers).freeze
  CAMPAIGN_DATE = /\A\d{4}-\d{2}-\d{2}\z/

  CAMPAIGN_SCHEDULE = <<~CSV.freeze
    2019-02-17,dogs
    2019-03-02,apples
    2019-12-31,paint
  CSV

  class CampaignSchedule
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

  def current_campaign(today = campaign_date)
    return campaign_override if campaign_override?

    case action_name
    when 'facebook'
      'dogs'
    when 'about'
      'peppers'
    else
      scheduled_campaign(today)
    end
  end

  def campaign_phone_number
    case params[:platform]
    when 'facebook'
      '0800 138 1586'
    when 'google'
      '0800 138 8293'
    when 'linkedin'
      '0800 138 1582'
    else
      '0800 138 3375'
    end
  end

  private

  def campaign_date_override?
    params.key?(:campaign_date) && params[:campaign_date].match?(CAMPAIGN_DATE)
  end

  def campaign_date_override
    Date.iso8601(params[:campaign_date].to_s)
  end

  def campaign_date
    campaign_date_override? ? campaign_date_override : Date.current
  end

  def campaign_override?
    params[:campaign].in?(CAMPAIGN_OVERRIDE)
  end

  def campaign_override
    params[:campaign]
  end

  def campaign_schedule
    CSV.parse(ENV.fetch('CAMPAIGN_SCHEDULE', CAMPAIGN_SCHEDULE), converters: [:date])
  end

  def scheduled_campaign(today)
    CampaignSchedule.current(campaign_schedule, today)
  end
end
