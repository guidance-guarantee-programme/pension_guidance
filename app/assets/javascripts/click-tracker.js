//= require click-event-logger.js

(function($) {
  'use strict';

  function track(selector, label, _url, _event, _onlyOnce) {
    var trackingMethod = 'sendEvent';
    if (_onlyOnce) {
      trackingMethod = 'sendEventOnlyOnce';
    }

    $(selector).on(_event || 'click', function() {
      PWPG.clickEventLogger[trackingMethod](label, _url || $(this).attr('href'));
    });
  }

  var clickTracker = {
    init: function() {
      // global
      track('#global-header a', 'global header');
      track('.l-masthead a', 'masthead');
      track('#footer a', 'footer');
      track('.js-nav > .nav__item', 'nav dropdown', window.location.pathname, 'mouseover', true);

      // homepage
      track('.l-home-top-slot .l-column-third a', 'introduction');
      track('.l-home-top-slot-promo a', 'appointments');
      track('.l-home-about a', 'about the service');
      track('.l-home-callouts a', 'callout guides');

      //guides
      track('.breadcrumbs a', 'breadcrumb');
      track('article a', 'content');
      track('.ga-options-table a', 'options table');
      track('.pager a', 'pager');
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.clickTracker = clickTracker;

})(jQuery);
