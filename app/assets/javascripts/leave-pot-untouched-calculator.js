(function($) {
  'use strict';

  var leavePotUntouchedCalculator = {
    init: function() {
      $('.leave-pot-untouched-calculator form').on('submit', function(event) {
        event.preventDefault();

        $.get('/leave-pot-untouched/results', $(this).serialize(), function(data) {
          $('.leave-pot-untouched-calculator__result').remove();
          $('.leave-pot-untouched-calculator form').append(data);
        });
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.leavePotUntouchedCalculator = leavePotUntouchedCalculator;
})(jQuery);
