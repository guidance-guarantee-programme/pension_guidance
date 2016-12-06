(function($) {
  'use strict';

  var mobileNavToggler = {
    init: function() {
      var $trigger = $('.js-nav-toggler');
      var $target = $('.js-nav');

      $trigger.click(function(e) {
        e.preventDefault();

        if ($target.hasClass('active')) {
          $target.removeClass('active');
          $target.attr('aria-hidden', true);
          $trigger.attr('aria-expanded', false);
        } else {
          $target.addClass('active');
          $target.attr('aria-hidden', false);
          $trigger.attr('aria-expanded', true);
        }
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.mobileNavToggler = mobileNavToggler;

})(jQuery);
