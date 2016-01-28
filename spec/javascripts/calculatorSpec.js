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

    function stubAJAXSubmissions(deferred) {
      var promise = deferred || $.Deferred();
      spyOn($, 'ajax').and.returnValue(promise);
      return promise;
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

    it('calls the `updateResults` method on AJAX success', function() {
      var $form = this.$calculator.find('form');

      spyOn(PWPG.calculators, 'updateResults');
      spyOn(PWPG.calculators, 'submitForm').and.callFake(function() {
        return $.Deferred().resolve();
      });

      $form.trigger('submit');

      expect(PWPG.calculators.updateResults).toHaveBeenCalled();
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

    it('updates the results when `updateResults` is called', function() {
      var data = 'results';

      PWPG.calculators.updateResults(data);
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

      PWPG.calculators.updateResults();
      scrollPromise.resolve();

      expect($loadingIndicator).not.toHaveClass('calculator__loading-status--loading');
    });

    it('adds a polite aria alert to the container on load', function() {
      expect($('.js-calculator').attr('aria-live')).toEqual('polite');
    });
  });
});
