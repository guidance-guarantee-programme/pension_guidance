(function() {
  'use strict';

  function TakeWholePotCalculator() {
    this.standardPersonalAllowance = 10600;
    this.personalAllowanceReductionThreshold = 100000;
    this.personalAllowanceReductionRatio = 2;
  }

  TakeWholePotCalculator.prototype.personalAllowanceFor = function(totalIncome) {
    if (totalIncome <= this.personalAllowanceReductionThreshold) {
      return this.standardPersonalAllowance;
    } else {
      var overThreshold = totalIncome - this.personalAllowanceReductionThreshold,
          reduction = Math.min(Math.floor(overThreshold / this.personalAllowanceReductionRatio),
                               this.standardPersonalAllowance);

      return this.standardPersonalAllowance - reduction;
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.takeWholePotCalculator = TakeWholePotCalculator;
})();
