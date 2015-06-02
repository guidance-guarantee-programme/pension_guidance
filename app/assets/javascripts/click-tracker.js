//= require click-event-logger.js

(function($) {
  'use strict';

  var clickTracker = {
    init: function(clickEventLogger) {
      clickEventLogger = clickEventLogger || new PWPG.ClickEventLogger();

      var track = function track(selector, label) {
        $(selector).on('click', function() {
          clickEventLogger.sendEvent(label, $(this).attr('href'));
        });
      };

      // global
      track('#global-header a', 'global header'); // global header links
      track('.l-masthead a', 'masthead'); // masthead links
      track('#footer a', 'footer'); // footer links

      // homepage
      track('.quick-links a', 'quick links'); // quick links
      track('.l-home-top-slot .l-column-third a', 'introduction'); // introduction links
      track('.l-home-top-slot-promo a', 'appointments'); // appointment links
      track('.journey-promo a', 'journey promo'); // journey promo links
      track('.l-home-guides a', 'guides directory'); // guide directory links
      track('.l-home-about a', 'about the service'); // about service links

      //guides
      track('.breadcrumbs a', 'breadcrumb'); // breadcrumb links
      track('article a', 'content'); // content links
      track('.ga-options-table a', 'options table'); // table links
      track('.pager a', 'pager'); // pager links
      track('.ga-journey-sidebar a', 'journey sidebar'); // journey sidebar links
      track('.ga-elsewhere-sidebar a', 'elsewhere sidebar'); // journey elsewhere links
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.clickTracker = clickTracker;

})(jQuery);
