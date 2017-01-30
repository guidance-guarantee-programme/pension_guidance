(function($) {
  'use strict';

  var $disableButtons = $('[data-disable-with]');

  $disableButtons.parents('form').on('submit', function() {
    var $currentFormButton = $(this).find($disableButtons);

    $currentFormButton.prop('disabled', true);
    $currentFormButton.val($currentFormButton.data('disable-with'));
  });
})(jQuery);
