(function($) {
  'use strict';

  var takeWholePotCalculator = {
    init: function() {
      var $calculator = $('.js-take-whole-pot-calculator form');
      var $result = $('<div class="calculator__result" aria-live="polite"></div>').appendTo($calculator);
      var $loadingStatus = $('<span class="calculator__loading-status">Please wait...</span>').
                            insertAfter($calculator.find('#js-calculate'));

      $calculator.on('submit', $.proxy(function(event) {
        event.preventDefault();

        this.toggleLoading($loadingStatus, true);

        $.get($calculator.attr('action'), $calculator.serialize()).then($.proxy(function(data) {
          $result.html(data).removeAttr('aria-live').attr('aria-live', 'polite');

          this.scrollTo($result).then($.proxy(function() {
            this.toggleLoading($loadingStatus, false);
          }, this));
        }, this));
      }, this));
    },

    toggleLoading: function($el, to) {
      $el[to ? 'show' : 'hide']();
    },

    scrollTo: function($el) {
      return $('html, body').animate({
        scrollTop: $el.offset().top
      }, 500).promise();
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.takeWholePotCalculator = takeWholePotCalculator;
})(jQuery);
