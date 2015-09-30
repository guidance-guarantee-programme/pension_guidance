(function($) {
  'use strict';

  var leavePotUntouchedCalculator = {
    init: function() {
      var $calculator = $('.js-leave-pot-untouched-calculator form');

      $calculator.append('<div class="calculator__result" aria-live="polite"></div>');

      $calculator.on('submit', function(event) {
        event.preventDefault();
        $.get('/leave-pot-untouched/results', $(this).serialize(), function(data) {
          $('.calculator__result').html(data);
        });
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.leavePotUntouchedCalculator = leavePotUntouchedCalculator;
})(jQuery);
