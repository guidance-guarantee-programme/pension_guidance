class AppointmentSummary
  include ActiveModel::Model

  TRUTHIES = [true, 'true', '1', 1].freeze

  attr_accessor *SUPPLEMENTARY_OPTIONS

  attr_writer :appointment_type, :urn

  SUPPLEMENTARY_OPTIONS.each do |attribute|
    define_method("#{attribute}=") do |value|
      instance_variable_set("@#{attribute}", TRUTHIES.member?(value))
    end
  end

  def initialize(params = {})
    super
  end

  validates :appointment_type, inclusion: { in: %w[standard 50_54] }
  validates :urn, format: { with: /P[A-Z]{2}\d-\d[A-Z]{3}/ }, allow_blank: true

  def appointment_type
    @appointment_type
  end

  def urn
    @urn
  end

  def format_preference
    'standard'
  end
end
