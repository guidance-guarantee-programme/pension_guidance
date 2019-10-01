class Referral < ApplicationRecord
  validates :surname, presence: true
  validates :date_of_birth, presence: true
  validates :pension_provider, presence: true
  validates :call_outcome, presence: true, on: :update

  scope :unresolved, -> { where(call_outcome: '') }

  def friendly_pension_provider
    PensionProvider[pension_provider]
  end
end
