(function($) {
  'use strict';

  var leavePotUntouchedCalculator = {
    init: function() {
      var $calculator = $('.js-leave-pot-untouched-calculator');

      $calculator.append('<div class="calculator__result" aria-live="polite"></div>');

      $calculator.find('form').on('submit', function(event) {
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
