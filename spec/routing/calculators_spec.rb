RSpec.describe 'Calculator routing', type: :routing do
  I18n.available_locales.each do |locale|
    it "routes /#{locale}/adjustable-income/estimate to calculators/adjustable_income#show" do
      expect(get("/#{locale}/adjustable-income/estimate"))
        .to route_to(locale: locale.to_s,
                     controller: 'calculators/adjustable_income',
                     action: 'show')
    end

    it "routes /#{locale}/guaranteed-income/estimate to calculators/guaranteed_income#show" do
      expect(get("/#{locale}/guaranteed-income/estimate"))
        .to route_to(locale: locale.to_s,
                     controller: 'calculators/guaranteed_income',
                     action: 'show')
    end

    it "routes /#{locale}/leave-pot-untouched/estimate to calculators/leave_pot_untouched#show" do
      expect(get("/#{locale}/leave-pot-untouched/estimate"))
        .to route_to(locale: locale.to_s,
                     controller: 'calculators/leave_pot_untouched',
                     action: 'show')
    end

    it "routes /#{locale}/take-cash-in-chunks/estimate to calculators/take_cash_in_chunks#show" do
      expect(get("/#{locale}/take-cash-in-chunks/estimate"))
        .to route_to(locale: locale.to_s,
                     controller: 'calculators/take_cash_in_chunks',
                     action: 'show')
    end

    it "routes /#{locale}/take-whole-pot/estimate to calculators/take_whole_pot#show" do
      expect(get("/#{locale}/take-whole-pot/estimate"))
        .to route_to(locale: locale.to_s,
                     controller: 'calculators/take_whole_pot',
                     action: 'show')
    end
  end
end
