(function($) {
  'use strict';

  var takeWholePotCalculator = {
    init: function() {
      var $calculator = $('.js-take-whole-pot-calculator form');

      $calculator.append('<div class="calculator__result" aria-live="polite"></div>');

      $calculator.on('submit', function(event) {
        event.preventDefault();
        $.get($calculator.attr('action'), $calculator.serialize()).then(function(data) {
          $result.html(data).removeAttr('aria-live').attr('aria-live', 'polite');
        });
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.takeWholePotCalculator = takeWholePotCalculator;
})(jQuery);
