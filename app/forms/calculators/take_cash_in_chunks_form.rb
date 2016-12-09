require 'active_model'

module Calculators
  class TakeCashInChunksForm
    include ActiveModel::Model

    Estimate = Struct.new(:pot, :pot_remaining, :chunk, :chunk_tax, :chunk_remaining)

    attr_reader :pot, :income, :chunk

    validates :pot,
              presence: true,
              numericality: { allow_blank: true, greater_than: 0 }

    validates :income,
              presence: true,
              numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

    validates :chunk,
              presence: true,
              numericality: { allow_blank: true, greater_than: 0,
                              less_than: ->(form) { form.errors.include?(:pot) ? Float::INFINITY : form.pot.to_f } }

    def pot=(pot)
      @pot = String(pot).delete(',').squish
    end

    def income=(income)
      @income = String(income).delete(',').squish
    end

    def chunk=(chunk)
      @chunk = String(chunk).delete(',').squish
    end

    def estimate
      income_tax = IncomeTaxCalculator.new(lump_sum: chunk.to_f, income: income.to_f)

      Estimate.new(pot.to_f, pot_remaining, chunk.to_f, income_tax.lump_sum_tax, income_tax.lump_sum_received)
    end

    private

    def pot_remaining
      pot.to_f - chunk.to_f
    end
  end
end
