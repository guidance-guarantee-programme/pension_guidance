$(function() {
  'use strict';

  $(document).on('click', '.js-scroll-to', function(e) {
      var $target = $($(this).attr('href')),
        offset = $target.offset();

      if (offset) {
        e.preventDefault();
        $('html, body').animate({
          'scrollTop': offset.top + 'px'
        });

        $target.attr('tabindex', -1);
        $target.focus();
      }
  });
});
