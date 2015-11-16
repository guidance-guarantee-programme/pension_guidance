(function() {
  'use strict';

  function TakeWholePotCalculator(income, pot) {
    this.income = income;
    this.pot = pot;

    this.standardPersonalAllowance = 10600;
    this.personalAllowanceReductionThreshold = 100000;
    this.personalAllowanceReductionRatio = 2;

    this.basicRateUpperLimit = 31785;
    this.basicRateTax = 0.2;

    this.higherRateUpperLimit = 150000;
    this.higherRateTax = 0.4;

    this.additionalRateTax = 0.45;

    this.taxablePotPortion = 0.75;
  }

  TakeWholePotCalculator.prototype.round = function(num) {
    return Math.round(num * 100) / 100;
  };

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

  TakeWholePotCalculator.prototype.marginalTaxForIncomeWithAllowance = function(income, allowance) {
    var taxableIncome,
        subjectToBasicRate = 0,
        subjectToHigherRate = 0,
        subjectToAdditionalRate = 0;

    if (income <= allowance) {
      taxableIncome = 0;
    } else if (income <= this.higherRateUpperLimit) {
      taxableIncome = income - allowance;
    } else {
      taxableIncome = income;
    }

    subjectToBasicRate = Math.min(taxableIncome, this.basicRateUpperLimit);

    if (taxableIncome > this.basicRateUpperLimit) {
      subjectToHigherRate = Math.min(taxableIncome - this.basicRateUpperLimit,
                                     this.higherRateUpperLimit - this.basicRateUpperLimit);
    }

    subjectToAdditionalRate = Math.max(taxableIncome - this.higherRateUpperLimit, 0);

    return {
      basic: this.round(subjectToBasicRate * this.basicRateTax),
      higher: this.round(subjectToHigherRate * this.higherRateTax),
      additional: this.round(subjectToAdditionalRate * this.additionalRateTax)
    };
  };

  TakeWholePotCalculator.prototype.marginalTaxForPotWithIncome = function(pot, income) {
    var potentiallyTaxablePot,
        remainingTaxablePot,
        incomeAboveAllowance,
        allowance,
        effectiveAllowance,
        effectiveBasicRateUpperLimit,
        effectiveHigherRateUpperLimit,
        subjectToBasicRate = 0,
        subjectToHigherRate = 0,
        subjectToAdditionalRate = 0;

    potentiallyTaxablePot = pot * this.taxablePotPortion;
    allowance = this.personalAllowanceFor(potentiallyTaxablePot + income);

    // adjust bands according to income
    incomeAboveAllowance = Math.max(income - allowance, 0);
    effectiveAllowance = Math.max(allowance - income, 0);
    effectiveBasicRateUpperLimit = Math.max(this.basicRateUpperLimit - incomeAboveAllowance, 0);
    effectiveHigherRateUpperLimit = Math.max(this.higherRateUpperLimit - incomeAboveAllowance, 0);

    remainingTaxablePot = potentiallyTaxablePot;

    // personal allowance
    if (remainingTaxablePot <= effectiveAllowance) {
      remainingTaxablePot = 0;
    } else {
      remainingTaxablePot = Math.max(remainingTaxablePot - effectiveAllowance, 0);
    }

    // basic rate
    subjectToBasicRate = Math.min(remainingTaxablePot, effectiveBasicRateUpperLimit);
    remainingTaxablePot -= subjectToBasicRate;

    // higher rate
    subjectToHigherRate = Math.min(remainingTaxablePot, (effectiveHigherRateUpperLimit - effectiveBasicRateUpperLimit));
    remainingTaxablePot -= subjectToHigherRate;

    // additional rate
    subjectToAdditionalRate = remainingTaxablePot;

    return {
      basic: this.round(subjectToBasicRate * this.basicRateTax),
      higher: this.round(subjectToHigherRate * this.higherRateTax),
      additional: this.round(subjectToAdditionalRate * this.additionalRateTax)
    };
  };

  TakeWholePotCalculator.prototype.taxFree = function() {
    return this.pot * (1 - this.taxablePotPortion);
  };

  TakeWholePotCalculator.prototype.taxable = function() {
    return this.pot * this.taxablePotPortion;
  };

  TakeWholePotCalculator.prototype.totalIncome = function() {
    return this.income + this.pot;
  };

  TakeWholePotCalculator.prototype.totalTaxable = function() {
    return this.income + this.taxable();
  };

  TakeWholePotCalculator.prototype.personalAllowance = function() {
    return this.personalAllowanceFor(this.income + this.taxable());
  };

  TakeWholePotCalculator.prototype.totalTax = function() {
    var tax = 0,
        incomeTax = this.marginalTaxForIncomeWithAllowance(this.income, this.personalAllowance()),
        potTax = this.marginalTaxForPotWithIncome(this.pot, this.income);

    for (var i in incomeTax) {
      tax += incomeTax[i];
    }

    for (i in potTax) {
      tax += potTax[i];
    }

    return tax;
  };

  TakeWholePotCalculator.prototype.incomeBands = function() {
    var tax = this.marginalTaxForIncomeWithAllowance(this.income, this.personalAllowance()),
        allowance = Math.min(this.income, this.personalAllowance());

    return {
      allowance: allowance,
      basic: tax.basic / this.basicRateTax,
      higher: tax.higher / this.higherRateTax,
      additional: tax.additional / this.additionalRateTax
    };
  };

  TakeWholePotCalculator.prototype.incomeTax = function() {
    var tax = this.marginalTaxForIncomeWithAllowance(this.income, this.personalAllowance());
    tax['allowance'] = 0;

    return tax;
  };

  TakeWholePotCalculator.prototype.incomeTaxTotal = function() {
    var tax = 0,
        incomeTax = this.marginalTaxForIncomeWithAllowance(this.income, this.personalAllowance());

    for (var i in incomeTax) {
      tax += incomeTax[i];
    }

    return tax;
  };

  TakeWholePotCalculator.prototype.potBands = function() {
    var tax = this.marginalTaxForPotWithIncome(this.pot, this.income),
        allowanceRemainder = Math.max(this.personalAllowance() - this.income, 0),
        allowance = Math.min(this.pot * this.taxablePotPortion, allowanceRemainder);

    return {
      allowance: allowance,
      basic: tax.basic / this.basicRateTax,
      higher: tax.higher / this.higherRateTax,
      additional: tax.additional / this.additionalRateTax
    };
  };

  TakeWholePotCalculator.prototype.potTax = function() {
    var tax = this.marginalTaxForPotWithIncome(this.pot, this.income);
    tax['allowance'] = 0;

    return tax;
  };

  TakeWholePotCalculator.prototype.potTaxTotal = function() {
    var tax = 0,
        incomeTax = this.marginalTaxForPotWithIncome(this.pot, this.income);

    for (var i in incomeTax) {
      tax += incomeTax[i];
    }

    return tax;
  };

  TakeWholePotCalculator.prototype.potNet = function() {
    return this.pot - this.potTaxTotal();
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.takeWholePotCalculator = TakeWholePotCalculator;
})();
