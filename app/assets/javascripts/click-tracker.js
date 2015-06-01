(function ($) {
  'use strict';

  window.PWPG = window.PWPG || {};

  var clickTracker = {
    pathname: window.location.pathname,
    init: function () {
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

      //guides
      bindBreadcrumbLinks();
      bindContentLinks();
      bindTableLinks();
      bindPagerLinks();
      bindJourneySidebarLinks();
      bindJourneyElsewhereLinks();
    },
    categoryName: function() {
      var name = this.pathname.replace('/', '');
      return name || 'homepage';
    },
    sendEvent: function(actionLabel) {
      ga('send', 'event', this.categoryName(), actionLabel, $(this).attr('href'));
    }
  };

  // PRIVATE METHODS
  function bindGlobalHeaderLinks() {
    $('#global-header a').on('click', function() {
      clickTracker.sendEvent('global header');
    });
  }

  function bindMastheadLinks() {
    $('.l-masthead a').on('click', function() {
      clickTracker.sendEvent('masthead');
    });
  }

  function bindFooterLinks() {
    $('#footer a').on('click', function() {
      clickTracker.sendEvent('footer');
    });
  }

  function bindQuickLinksLinks() {
    $('.quick-links a').on('click', function() {
      clickTracker.sendEvent('quick links');
    });
  }

  function bindIntroductionLinks() {
    $('.l-home-top-slot .l-column-third a').on('click', function() {
      clickTracker.sendEvent('introduction');
    });
  }

  function bindAppointmentLinks() {
    $('.l-home-top-slot-promo a').on('click', function() {
      clickTracker.sendEvent('appointments');
    });
  }

  function bindJourneyPromoLinks() {
    $('.journey-promo a').on('click', function() {
      clickTracker.sendEvent('journey promo');
    });
  }

  function bindGuideDirectoryLinks() {
    $('.l-home-guides a').on('click', function() {
      clickTracker.sendEvent('guides directory');
    });
  }

  function bindAboutServiceLinks() {
    $('.l-home-about a').on('click', function() {
      clickTracker.sendEvent('about the service');
    });
  }

  function bindBreadcrumbLinks() {
    $('.breadcrumbs a').on('click', function() {
      clickTracker.sendEvent('breadcrumb');
    });
  }

  function bindContentLinks() {
    $('article a').on('click', function() {
      clickTracker.sendEvent('content');
    });
  }

  function bindTableLinks() {
    $('.ga-options-table a').on('click', function() {
      clickTracker.sendEvent('options table');
    });
  }

  function bindPagerLinks() {
    $('.pager a').on('click', function() {
      clickTracker.sendEvent('pager');
    });
  }

  function bindJourneySidebarLinks() {
    $('.ga-journey-sidebar a').on('click', function() {
      clickTracker.sendEvent('journey sidebar');
    });
  }

  function bindJourneyElsewhereLinks() {
    $('.ga-elsewhere-sidebar a').on('click', function() {
      clickTracker.sendEvent('elsewhere sidebar');
    });
  }

  PWPG.clickTracker = clickTracker;

})(jQuery);
