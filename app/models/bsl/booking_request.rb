module Bsl
  class BookingRequest
    include ActiveModel::Model

    attr_accessor(
      :first_name,
      :last_name,
      :email,
      :phone,
      :memorable_word,
      :defined_contribution_pot_confirmed,
      :accessibility_needs,
      :additional_info,
      :where_you_heard,
      :gdpr_consent
    )

    attr_writer :date_of_birth

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, email: true
    validates :phone, presence: true, format: /\A([\d+\-\s\+()]+)\z/
    validates :memorable_word, presence: true
    validates :accessibility_needs, inclusion: { in: %w(0 1) }
    validates :defined_contribution_pot_confirmed, inclusion: { in: %w(yes not-sure) }
    validates :date_of_birth, presence: true
    validates :additional_info, length: { maximum: 160 }, allow_blank: true
    validates :where_you_heard, inclusion: { in: WhereYouHeard::OPTIONS.keys }
    validate :validate_age_eligibility, if: :date_of_birth

    def date_of_birth
      return nil unless /\d{4}-\d{1,2}-\d{1,2}/.match?(@date_of_birth)

      Date.parse(@date_of_birth)
    end

    def payload
      Mapper.new(self).call
    end

    private

    def validate_age_eligibility
      errors.add(:date_of_birth) if age < 50
    end

    def age
      return 0 unless date_of_birth

      age = Time.zone.today.year - date_of_birth.year
      age -= 1 if Time.zone.today.to_date < date_of_birth + age.years
      age
    end
  end
end
