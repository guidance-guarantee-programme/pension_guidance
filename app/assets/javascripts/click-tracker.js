(function ($) {
  'use strict';

  window.PWPG = window.PWPG || {};

  var clickTracker = {
    pathname: window.location.pathname,
    init: function () {
      this.bind();
    },
    bind: function() {

      // global
      bindGlobalHeaderLinks();
      bindMastheadLinks();
      bindFooterLinks();

      // homepage
      bindQuickLinksLinks();
      bindIntroductionLinks();
      bindAppointmentLinks();
      bindJourneyPromoLinks();
      bindGuideDirectoryLinks();
      bindAboutServiceLinks();

    },
    categoryName: function() {
      var name = this.pathname.replace('/', '');
      return name || 'homepage';
    },
    sendEvent: function(actionLabel) {
      ga('send', 'event', this.categoryName(), actionLabel, $(this).attr('href'));
    }
  };

  function bindGlobalHeaderLinks() {
    $('#global-header a').on( 'click', function() {
      clickTracker.sendEvent('global header');
    });
  }

  function bindMastheadLinks() {
    $('.l-masthead a').on( 'click', function() {
      clickTracker.sendEvent('masthead');
    });
  }

  function bindFooterLinks() {
    $('#footer a').on( 'click', function() {
      clickTracker.sendEvent('footer');
    });
  }

  function bindQuickLinksLinks() {
    $('.quick-links a').on( 'click', function() {
      clickTracker.sendEvent('quick links');
    });
  }

  function bindIntroductionLinks() {
    $('.l-home-top-slot .l-column-third a').on( 'click', function() {
      clickTracker.sendEvent('introduction');
    });
  }

  function bindAppointmentLinks() {
    $('.l-home-top-slot-promo a').on( 'click', function() {
      clickTracker.sendEvent('appointments');
    });
  }

  function bindJourneyPromoLinks() {
    $('.journey-promo a').on( 'click', function() {
      clickTracker.sendEvent('journey promo');
    });
  }

  function bindGuideDirectoryLinks() {
    $('.l-home-guides a').on( 'click', function() {
      clickTracker.sendEvent('guides directory');
    });
  }

  function bindAboutServiceLinks() {
    $('.l-home-about a').on( 'click', function() {
      clickTracker.sendEvent('about the service');
    });
  }

  PWPG.clickTracker = clickTracker;

})(jQuery);
