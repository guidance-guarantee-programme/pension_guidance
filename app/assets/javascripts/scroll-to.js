$(function() {
  'use strict';

  $(document).on('click', '.js-scroll-to', function(e) {
      var $target = $($(this).attr('href')),
        offset = $target.offset();

      if (!offset) {
        return;
      }

      e.preventDefault();
      $('html, body').animate({
        'scrollTop': offset.top + 'px'
      });

      $target.attr('tabindex', -1).on('blur', (event) => {
        $(event.currentTarget)
          .removeAttr('tabindex')
          .off('blur');
      }).focus();
  });
});
