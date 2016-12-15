(function($) {
  'use strict';

  var scrollTo = {
    init: function() {
      $(document).on('click', '.js-scroll-to', this.handleScroll);
    },
    handleScroll: function(e) {
      var baseSpeed = 700,
        $link = $(e.currentTarget),
        $target = $($link.attr('href')),
        linkOffset = $link.offset(),
        targetOffset = $target.offset(),
        offsetDiff = 0,
        speed = 0,
        bodyHeight = $('body').height();

      if (!targetOffset) {
        return;
      }

      e.preventDefault();

      var distance = Math.abs(targetOffset.top - linkOffset.top);

      speed = (1 - (distance / bodyHeight)) * baseSpeed;

      $('html, body').animate({
        'scrollTop': targetOffset.top + 'px'
      }, speed);

      $target.attr('tabindex', -1).on('blur', function(e) {
        $(e.currentTarget).removeAttr('tabindex').off('blur');
      }).focus();
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.scrollTo = scrollTo;
})(jQuery);
