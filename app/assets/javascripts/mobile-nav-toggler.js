(function($) {
  'use strict';

  var mobileNavToggler = {
    init: function() {
      var $trigger = $('.js-menu-toggler');
      var $target = $('.js-menu');

      $trigger.click(function(e) {
        e.preventDefault();
        $target.slideToggle();
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.mobileNavToggler = mobileNavToggler;

})(jQuery);
