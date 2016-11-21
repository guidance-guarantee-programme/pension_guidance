(function($) {
  'use strict';

  var button = $('[data-disable-with]');

  button.parents('form').on('submit', function() {
    button.prop('disabled', true);
    button.val(button.data('disable-with'));
  });
})(jQuery);
