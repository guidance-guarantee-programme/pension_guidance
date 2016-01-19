(function($) {
  'use strict';

  var mobileNavToggler = {
    init: function() {
      var $trigger = $('.js-nav-toggler');
      var $target = $('.js-nav');

      $trigger.click(function(e) {
        e.preventDefault();
        $target.toggleClass('active');
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.mobileNavToggler = mobileNavToggler;

})(jQuery);
