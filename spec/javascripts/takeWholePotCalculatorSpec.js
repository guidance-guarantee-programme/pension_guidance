describe('WholePotCalculator', function() {
  'use strict';

  //jscs:disable disallowMultipleSpaces
  var acceptanceScenarios = [{
    income:            0,
    pot:               10000,
    taxFree:           2500,
    taxable:           7500,
    totalIncome:       10000,
    personalAllowance: 10600,
  },{
    income:            10000,
    pot:               20000,
    taxFree:           5000,
    taxable:           15000,
    totalIncome:       30000,
    personalAllowance: 10600,
  },{
    income:            30000,
    pot:               50000,
    taxFree:           12500,
    taxable:           37500,
    totalIncome:       80000,
    personalAllowance: 10600,
  },{
    income:            0,
    pot:               160000,
    taxFree:           40000,
    taxable:           120000,
    totalIncome:       160000,
    personalAllowance: 600,
  },{
    income:            70000,
    pot:               250000,
    taxFree:           62500,
    taxable:           187500,
    totalIncome:       320000,
    personalAllowance: 0,
  }];
  //jscs:enable disallowMultipleSpaces

  describe('#personalAllowanceFor', function() {
    var calculator = new PWPG.takeWholePotCalculator();

    describe('when £100,000 and below total income', function() {
      it('calculates the personal allowance', function() {
        expect(calculator.personalAllowanceFor(100000)).toBe(10600);
      });
    });

    describe('when between £100,000 and £121,200 total income', function() {
      it('calculates the personal allowance', function() {
        expect(calculator.personalAllowanceFor(110000)).toBe(5600);
      });
    });

    describe('when £121,200 and above total income', function() {
      it('calculates the personal allowance', function() {
        expect(calculator.personalAllowanceFor(122000)).toBe(0);
      });
    });
  });

  describe('#marginalTaxForIncomeWithAllowance', function() {
    var calculator = new PWPG.takeWholePotCalculator();

    describe('when income is 0', function() {
      it('calculates the marginal tax', function() {
        expect(calculator.marginalTaxForIncomeWithAllowance(0, 10600)).toEqual({
          basic: 0,
          higher: 0,
          additional: 0
        });
      });
    });

    describe('when income is within the personal allowance', function() {
      it('calculates the marginal tax', function() {
        expect(calculator.marginalTaxForIncomeWithAllowance(10000, 10600)).toEqual({
          basic: 0,
          higher: 0,
          additional: 0
        });
      });
    });

    describe('when income is within the basic rate band', function() {
      it('calculates the marginal tax', function() {
        expect(calculator.marginalTaxForIncomeWithAllowance(20000, 10600)).toEqual({
          basic: 1880,
          higher: 0,
          additional: 0
        });
      });
    });

    describe('when income is within the higher rate band', function() {
      it('calculates the marginal tax', function() {
        expect(calculator.marginalTaxForIncomeWithAllowance(45000, 10600)).toEqual({
          basic: 6357,
          higher: 1046,
          additional: 0
        });
      });
    });

    describe('when income is within the additional rate band', function() {
      it('calculates the marginal tax', function() {
        expect(calculator.marginalTaxForIncomeWithAllowance(160000, 10600)).toEqual({
          basic: 6357,
          higher: 47286,
          additional: 4500
        });
      });
    });
  });

  describe('#marginalTaxForPotWithIncome', function() {
    var calculator = new PWPG.takeWholePotCalculator();

    describe('when income is 0', function() {
      describe('and taxable portion of pot is within the personal allowance', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(10000, 0)).toEqual({
            basic: 0,
            higher: 0,
            additional: 0
          });
        });
      });

      describe('and taxable portion of pot is within the basic rate band', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(20000, 0)).toEqual({
            basic: 880,
            higher: 0,
            additional: 0
          });
        });
      });

      describe('and taxable portion of pot is within the higher rate band', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(60000, 0)).toEqual({
            basic: 6357,
            higher: 1046,
            additional: 0
          });
        });
      });

      describe('and taxable portion of pot is within the additional rate band', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(220000, 0)).toEqual({
            basic: 6357,
            higher: 47286,
            additional: 6750
          });
        });
      });
    });

    describe('when income is within the basic rate band', function() {
      describe('and taxable portion of pot is within the basic rate band', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(20000, 15000)).toEqual({
            basic: 3000,
            higher: 0,
            additional: 0
          });
        });
      });

      describe('and taxable portion of pot is within the higher rate band', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(40000, 15000)).toEqual({
            basic: 5477,
            higher: 1046,
            additional: 0
          });
        });
      });

      describe('and taxable portion of pot is within the additional rate band', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(200000, 15000)).toEqual({
            basic: 3357,
            higher: 47286,
            additional: 6750
          });
        });
      });
    });

    describe('when income is within the higher rate band', function() {
      describe('and taxable portion of pot is within the higher rate band', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(20000, 45000)).toEqual({
            basic: 0,
            higher: 6000,
            additional: 0
          });
        });
      });

      describe('and taxable portion of pot is within the additional rate band', function() {
        it('calculates the marginal tax', function() {
          expect(calculator.marginalTaxForPotWithIncome(20000, 160000)).toEqual({
            basic: 0,
            higher: 0,
            additional: 6750
          });
        });
      });
    });

    describe('when income is within the additional rate band', function() {
      it('calculates the marginal tax', function() {
        expect(calculator.marginalTaxForPotWithIncome(20000, 150000)).toEqual({
          basic: 0,
          higher: 0,
          additional: 6750
        });
      });
    });
  });

  describe('#taxFree', function() {
    it('calculates the tax-free portion of the pot', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.taxFree()).toEqual(scenario.taxFree);
      }
    });
  });

  describe('#taxable', function() {
    it('calculates the taxable portion of the pot', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.taxable()).toEqual(scenario.taxable);
      }
    });
  });

  describe('#totalIncome', function() {
    it('calculates the total income for the year', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.totalIncome()).toEqual(scenario.totalIncome);
      }
    });
  });

  describe('#personalAllowance', function() {
    it('calculates the personal allowance', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.personalAllowance()).toEqual(scenario.personalAllowance);
      }
    });
  });
});
