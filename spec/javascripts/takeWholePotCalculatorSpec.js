describe('WholePotCalculator', function() {
  'use strict';

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
});
