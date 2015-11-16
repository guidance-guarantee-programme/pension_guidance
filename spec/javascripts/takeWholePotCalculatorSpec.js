describe('WholePotCalculator', function() {
  'use strict';

  //jscs:disable disallowMultipleSpaces
  var acceptanceScenarios = [{
    income:            0,
    pot:               10000,
    taxFree:           2500,
    taxable:           7500,
    totalIncome:       10000,
    totalTaxable:      7500,
    personalAllowance: 10600,
    incomeBands:       {
      allowance:       0,
      basic:           0,
      higher:          0,
      additional:      0
    },
    incomeTax:         {
      allowance:       0,
      basic:           0,
      higher:          0,
      additional:      0
    },
    incomeTaxTotal:    0,
    potBands:          {
      allowance:       7500,
      basic:           0,
      higher:          0,
      additional:      0
    },
    potTax:            {
      allowance:       0,
      basic:           0,
      higher:          0,
      additional:      0
    },
    potTaxTotal:       0,
    potNet:            10000,
    totalTax:          0
  },{
    income:            10000,
    pot:               20000,
    taxFree:           5000,
    taxable:           15000,
    totalIncome:       30000,
    totalTaxable:      25000,
    personalAllowance: 10600,
    incomeBands:       {
      allowance:       10000,
      basic:           0,
      higher:          0,
      additional:      0
    },
    incomeTax:         {
      allowance:       0,
      basic:           0,
      higher:          0,
      additional:      0
    },
    incomeTaxTotal:    0,
    potBands:          {
      allowance:       600,
      basic:           14400,
      higher:          0,
      additional:      0
    },
    potTax:            {
      allowance:       0,
      basic:           2880,
      higher:          0,
      additional:      0
    },
    potTaxTotal:       2880,
    potNet:            17120,
    totalTax:          2880
  },{
    income:            30000,
    pot:               50000,
    taxFree:           12500,
    taxable:           37500,
    totalIncome:       80000,
    totalTaxable:      67500,
    personalAllowance: 10600,
    incomeBands:       {
      allowance:       10600,
      basic:           19400,
      higher:          0,
      additional:      0
    },
    incomeTax:         {
      allowance:       0,
      basic:           3880,
      higher:          0,
      additional:      0
    },
    incomeTaxTotal:    3880,
    potBands:          {
      allowance:       0,
      basic:           12385,
      higher:          25115,
      additional:      0
    },
    potTax:            {
      allowance:       0,
      basic:           2477,
      higher:          10046,
      additional:      0
    },
    potTaxTotal:       12523,
    potNet:            37477,
    totalTax:          16403
  },{
    income:            0,
    pot:               160000,
    taxFree:           40000,
    taxable:           120000,
    totalIncome:       160000,
    totalTaxable:      120000,
    personalAllowance: 600,
    incomeBands:       {
      allowance:       0,
      basic:           0,
      higher:          0,
      additional:      0
    },
    incomeTax:         {
      allowance:       0,
      basic:           0,
      higher:          0,
      additional:      0
    },
    incomeTaxTotal:    0,
    potBands:          {
      allowance:       600,
      basic:           31785,
      higher:          87615,
      additional:      0
    },
    potTax:            {
      allowance:       0,
      basic:           6357,
      higher:          35046,
      additional:      0
    },
    potTaxTotal:       41403,
    potNet:            118597,
    totalTax:          41403
  },{
    income:            70000,
    pot:               250000,
    taxFree:           62500,
    taxable:           187500,
    totalIncome:       320000,
    totalTaxable:      257500,
    personalAllowance: 0,
    incomeBands:       {
      allowance:       0,
      basic:           31785,
      higher:          38215,
      additional:      0
    },
    incomeTax:         {
      allowance:       0,
      basic:           6357,
      higher:          15286,
      additional:      0
    },
    incomeTaxTotal:    21643,
    potBands:          {
      allowance:       0,
      basic:           0,
      higher:          80000,
      additional:      107500
    },
    potTax:            {
      allowance:       0,
      basic:           0,
      higher:          32000,
      additional:      48375
    },
    potTaxTotal:       80375,
    potNet:            169625,
    totalTax:          102018
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

  describe('#totalTaxable', function() {
    it('calculates the total taxable monies for the year', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.totalTaxable()).toEqual(scenario.totalTaxable);
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

  describe('#totalTax', function() {
    it('calculates the total tax', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.totalTax()).toEqual(scenario.totalTax);
      }
    });
  });

  describe('#incomeBands', function() {
    it('calculates the income in each of the tax bands', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.incomeBands()).toEqual(scenario.incomeBands);
      }
    });
  });

  describe('#incomeTax', function() {
    it('calculates the income tax in each of the bands', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.incomeTax()).toEqual(scenario.incomeTax);
      }
    });
  });

  describe('#incomeTaxTotal', function() {
    it('calculates the total tax on the income', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.incomeTaxTotal()).toEqual(scenario.incomeTaxTotal);
      }
    });
  });

  describe('#potBands', function() {
    it('calculates the pot in each of the tax bands', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.potBands()).toEqual(scenario.potBands);
      }
    });
  });

  describe('#potTax', function() {
    it('calculates the pot tax in each of the bands', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.potTax()).toEqual(scenario.potTax);
      }
    });
  });

  describe('#potTaxTotal', function() {
    it('calculates the total tax on the pot', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.potTaxTotal()).toEqual(scenario.potTaxTotal);
      }
    });
  });

  describe('#potNet', function() {
    it('calculates the after-tax pot amount', function() {
      for (var i in acceptanceScenarios) {
        var scenario = acceptanceScenarios[i],
            calculator = new PWPG.takeWholePotCalculator(scenario.income, scenario.pot);

        expect(calculator.potNet()).toEqual(scenario.potNet);
      }
    });
  });
});
