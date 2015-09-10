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
});
