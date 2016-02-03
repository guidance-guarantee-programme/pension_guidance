require 'active_model'

module Calculators
  class LeavePotUntouchedForm
    include ActiveModel::Model

    attr_reader :pot, :contribution

    validates :pot, presence: true, numericality: { allow_blank: true, greater_than: 0 }
    validates :contribution, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

    def pot=(pot)
      @pot = String(pot).gsub(/,/, '').squish
    end

    def contribution=(contribution)
      @contribution = String(contribution).gsub(/,/, '').squish
    end

    def result
      LeavePotUntouchedCalculator.new(pot: pot.to_f, contribution: contribution.to_f).result if valid?
    end
  end
end
