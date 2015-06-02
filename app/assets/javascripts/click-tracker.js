//= require click-event-logger.js

(function($) {
  'use strict';

  function track(selector, label) {
    $(selector).on('click', function() {
      PWPG.clickEventLogger.sendEvent(label, $(this).attr('href'));
    });
  }

  var clickTracker = {
    init: function() {
      // global
      track('#global-header a', 'global header');
      track('.l-masthead a', 'masthead');
      track('#footer a', 'footer');

      // homepage
      track('.quick-links a', 'quick links');
      track('.l-home-top-slot .l-column-third a', 'introduction');
      track('.l-home-top-slot-promo a', 'appointments');
      track('.journey-promo a', 'journey promo');
      track('.l-home-guides a', 'guides directory');
      track('.l-home-about a', 'about the service');

      //guides
      track('.breadcrumbs a', 'breadcrumb');
      track('article a', 'content');
      track('.ga-options-table a', 'options table');
      track('.pager a', 'pager');
      track('.ga-journey-sidebar a', 'journey sidebar');
      track('.ga-elsewhere-sidebar a', 'elsewhere sidebar');
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.clickTracker = clickTracker;

})(jQuery);
