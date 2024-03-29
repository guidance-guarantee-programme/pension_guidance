class AppointmentSummary
  include ActiveModel::Model

  TRUTHIES = [true, 'true', '1', 1].freeze

  attr_accessor *SUPPLEMENTARY_OPTIONS

  attr_writer :appointment_type

  SUPPLEMENTARY_OPTIONS.each do |attribute|
    define_method("#{attribute}=") do |value|
      instance_variable_set("@#{attribute}", TRUTHIES.member?(value))
    end
  end

  def initialize(params = {})
    super
  end

  validates :appointment_type, inclusion: { in: %w[standard 50_54] }

  def appointment_type
    @appointment_type
  end

  def format_preference
    'standard'
  end
end
