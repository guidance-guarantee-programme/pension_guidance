module Tesco
  class Booking
    include ActiveModel::Model

    attr_accessor(
      :id,
      :step,
      :selected_date,
      :start_at,
      :first_name,
      :last_name,
      :email,
      :phone,
      :memorable_word,
      :appointment_type,
      :date_of_birth,
      :dc_pot_confirmed,
      :date_of_birth_year,
      :date_of_birth_month,
      :date_of_birth_day,
      :location_id,
      :room,
      :gdpr_consent
    )

    validates :start_at, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, email: true
    validates :phone, presence: true, format: /\A([\d+\-\s\+()]+)\z/
    validates :memorable_word, presence: true
    validates :date_of_birth, presence: true
    validates :dc_pot_confirmed, inclusion: { in: %w(yes no not-sure) }

    def advance!
      self.step += 1
      yield
    end

    def reset!
      self.step = 1
      yield
    end

    def eligible?
      age_at_appointment >= 50 && dc_pot_confirmed != 'no'
    end

    def ineligible?
      !eligible?
    end

    def attributes # rubocop:disable Metrics/MethodLength
      {
        start_at: start_at,
        first_name: first_name,
        last_name: last_name,
        email: email,
        phone: phone,
        memorable_word: memorable_word,
        date_of_birth: date_of_birth,
        dc_pot_confirmed: dc_pot_confirmed == 'yes',
        gdpr_consent: gdpr_consent.to_s
      }
    end

    def date_of_birth
      parts = [
        date_of_birth_year,
        date_of_birth_month,
        date_of_birth_day
      ]

      return unless parts.all?(&:present?)

      parts.map!(&:to_i)

      Date.new(*parts)
    end

    def selected_date
      Time.zone.parse(@selected_date) if @selected_date.present?
    end

    def start_at
      Time.zone.parse(@start_at) if @start_at.present?
    end

    def step
      Integer(@step || 1)
    end

    def save
      return unless valid?

      Tesco.create(self)
    end

    def age_at_appointment
      return 0 unless date_of_birth && start_at

      ((start_at.to_date - date_of_birth) / 365).floor
    end
  end
end
