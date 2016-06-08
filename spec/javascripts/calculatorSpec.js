//= require jasmine-jquery

jasmine.getFixtures().fixturesPath = '../../spec/javascripts/fixtures';

describe('calculators', function() {
  'use strict';

  it('should be defined', function() {
    expect(PWPG.calculators).toBeDefined();
  });

  describe('inline usage of the calculator', function() {
    beforeEach(function() {
      loadFixtures('calculator.html');
      PWPG.calculators.init();
      this.$calculator = $('.js-calculator');
    });

    afterEach(function() {
      this.$calculator.remove();
    });

    function stubAJAXSubmissions(deferred) {
      var promise = deferred || $.Deferred();
      spyOn($, 'ajax').and.returnValue(promise);
      return promise;
    }

    function addSlider(html) {
      var $worker = $('<div/>');
      $worker.append(html)
             .find('.js-calculator-estimate')
             .append('<div id="slider" data-slider>' +
                        '<input data-slider-text-input class="t-slider-input" />' +
                      '</div>');

      return $worker.html();
    }

    it('creates a `loading-status` on load', function() {
      expect(this.$calculator.find('.calculator__loading-status').length).toBe(1);
    });

    it('prevents default on form submission', function() {
      var $form = this.$calculator.find('form');
      var spyEvent = spyOnEvent($form, 'submit');
      stubAJAXSubmissions();

      $form.trigger('submit');

      expect(spyEvent).toHaveBeenPrevented();
    });

    it('calls `submitForm` on form submission', function() {
      var $form = this.$calculator.find('form');

      stubAJAXSubmissions();
      spyOn(PWPG.calculators, 'submitForm').and.callThrough();

      $form.trigger('submit');

      expect(PWPG.calculators.submitForm.calls.count()).toEqual(1);
    });

    it('makes an AJAX request to the correct URL', function(done) {
      var promise = stubAJAXSubmissions();

      PWPG.calculators.submitForm().then(function() {
        expect($.ajax.calls.mostRecent().args[0]['url']).toEqual('/calculator');
        done();
      });

      promise.resolve();
    });

    it('calls the `updateEstimate` method on AJAX success', function() {
      var $form = this.$calculator.find('form');

      spyOn(PWPG.calculators, 'updateEstimate');
      spyOn(PWPG.calculators, 'submitForm').and.callFake(function() {
        return $.Deferred().resolve();
      });

      $form.trigger('submit');

      expect(PWPG.calculators.updateEstimate).toHaveBeenCalled();
    });

    it('calls the `handleError` method on AJAX failure', function() {
      var $form = this.$calculator.find('form');

      spyOn(PWPG.calculators, 'handleError');
      spyOn(PWPG.calculators, 'submitForm').and.callFake(function() {
        return $.Deferred().reject();
      });

      $form.trigger('submit');

      expect(PWPG.calculators.handleError).toHaveBeenCalled();
    });

    it('updates the estimate when `updateEstimate` is called', function() {
      var data = 'estimate';

      PWPG.calculators.updateEstimate(data);
      expect(this.$calculator.html()).toEqual(data);
    });

    it('displays the loading indicator during the request', function() {
      var $loadingIndicator = this.$calculator.find('.calculator__loading-status');

      stubAJAXSubmissions();

      PWPG.calculators.submitForm();
      expect($loadingIndicator).toHaveClass('calculator__loading-status--loading');
    });

    it('hides the loading indicator after the request', function() {
      var $loadingIndicator = this.$calculator.find('.calculator__loading-status');
      var scrollPromise = $.Deferred();

      $loadingIndicator.addClass('calculator__loading-status--loading');

      spyOn(PWPG.calculators, '_scrollTo').and.returnValue(scrollPromise);

      PWPG.calculators.updateEstimate();
      scrollPromise.resolve();

      $loadingIndicator = this.$calculator.find('.calculator__loading-status');
      expect($loadingIndicator).not.toHaveClass('calculator__loading-status--loading');
    });

    it('adds a polite aria alert to the container on load', function() {
      expect($('.js-calculator').attr('aria-live')).toEqual('polite');
    });

    it('shows the calculator to print media on AJAX success', function() {
      var $form = this.$calculator.find('form');

      spyOn(PWPG.calculators, 'submitForm').and.callFake(function() {
        return $.Deferred().resolve();
      });

      $form.trigger('submit');

      expect(this.$calculator).not.toHaveClass('hide-from-print');
    });

    it('scrolls to the submit button on estimate update by default', function() {
      var $actualScrollToTarget;
      var $defaultScrollTarget = this.$calculator.find('.js-calculate-submit');

      spyOn(PWPG.calculators, '_scrollTo').and.returnValue($.Deferred());
      spyOn(PWPG.calculators, 'updateEstimate').and.callThrough();

      PWPG.calculators.updateEstimate(this.$calculator.html());

      $actualScrollToTarget = $(PWPG.calculators._scrollTo.calls.mostRecent().args[0]);
      expect($actualScrollToTarget.attr('class')).toEqual($defaultScrollTarget.attr('class'));
    });

    it('scrolls to the `js-scroll-target` on estimate update when it exists', function() {
      var $actualScrollToTarget;
      var $customScrollTarget = $('<div class="js-scroll-target"/>').
                                  appendTo(this.$calculator);

      spyOn(PWPG.calculators, '_scrollTo').and.returnValue($.Deferred());
      spyOn(PWPG.calculators, 'updateEstimate').and.callThrough();

      PWPG.calculators.updateEstimate(this.$calculator.html());

      $actualScrollToTarget = $(PWPG.calculators._scrollTo.calls.mostRecent().args[0]);
      expect($actualScrollToTarget.attr('class')).toEqual($customScrollTarget.attr('class'));
    });

    it('scrolls to the top of the calculator on failure', function() {
      var $actualScrollToTarget;
      var $defaultScrollTarget = this.$calculator;

      spyOn(PWPG.calculators, '_scrollTo').and.returnValue($.Deferred());
      spyOn(PWPG.calculators, 'handleError').and.callThrough();

      PWPG.calculators.handleError({ responseText: 'test' });

      $actualScrollToTarget = $(PWPG.calculators._scrollTo.calls.mostRecent().args[0]);
      expect($actualScrollToTarget.attr('class')).toEqual($defaultScrollTarget.attr('class'));
    });

    it('initalises a slider when slider is present in estimate response', function() {
      var estimateWithSliderHTML = addSlider(this.$calculator.html());
      var spy = spyOn(PWPG.Slider.prototype, 'init').and.callThrough();

      PWPG.calculators.updateEstimate(estimateWithSliderHTML);

      expect(spy).toHaveBeenCalled();
    });

    it('submits the form when the slider is changed', function(done) {
      var estimateWithSliderHTML = addSlider(this.$calculator.html());
      var $slider;

      spyOn(PWPG.calculators, 'submitForm').and.returnValue($.Deferred());
      PWPG.calculators.updateEstimate(estimateWithSliderHTML);

      $slider = this.$calculator.find('.t-slider-input');
      $slider.keyup();

      setTimeout(function() {
        expect(PWPG.calculators.submitForm).toHaveBeenCalled();
        done();
      }, 200);
    });
  });
});
