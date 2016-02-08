require 'active_model'

module Calculators
  class LeavePotUntouchedForm
    include ActiveModel::Model

    attr_reader :pot, :contribution, :experiment

    validates :pot, presence: true, numericality: { allow_blank: true, greater_than: 0 }
    validates :contribution, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

    def pot=(pot)
      @pot = String(pot).delete(',').squish
    end

    def contribution=(contribution)
      @contribution = String(contribution).delete(',').squish
    end

    def experiment=(experiment)
      @experiment = String(experiment)
    end

    def estimate
      LeavePotUntouchedCalculator.new(
        pot: pot.to_f,
        contribution: contribution.to_f).estimate if valid?
    end

    def bumped_estimate
      LeavePotUntouchedCalculator.new(
        pot: pot.to_f,
        contribution: contribution.to_f + 20).estimate if valid?
    end

    def difference_in_bumped_estimate
      bumped_estimate.last.to_f - estimate.last.to_f
    end
  end
end
