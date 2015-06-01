(function($) {
  'use strict';

  window.PWPG = window.PWPG || {};

  var clickTracker = {
    pathname: window.location.pathname,
    init: function() {
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
    sendEvent: function(actionLabel, url) {
      ga('send', 'event', this.categoryName(), actionLabel, url);
    }
  };

  // PRIVATE METHODS
  function bindGlobalHeaderLinks() {
    $('#global-header a').on('click', function() {
      clickTracker.sendEvent('global header', $(this).attr('href'));
    });
  }

  function bindMastheadLinks() {
    $('.l-masthead a').on('click', function() {
      clickTracker.sendEvent('masthead', $(this).attr('href'));
    });
  }

  function bindFooterLinks() {
    $('#footer a').on('click', function() {
      clickTracker.sendEvent('footer', $(this).attr('href'));
    });
  }

  function bindQuickLinksLinks() {
    $('.quick-links a').on('click', function() {
      clickTracker.sendEvent('quick links', $(this).attr('href'));
    });
  }

  function bindIntroductionLinks() {
    $('.l-home-top-slot .l-column-third a').on('click', function() {
      clickTracker.sendEvent('introduction', $(this).attr('href'));
    });
  }

  function bindAppointmentLinks() {
    $('.l-home-top-slot-promo a').on('click', function() {
      clickTracker.sendEvent('appointments', $(this).attr('href'));
    });
  }

  function bindJourneyPromoLinks() {
    $('.journey-promo a').on('click', function() {
      clickTracker.sendEvent('journey promo', $(this).attr('href'));
    });
  }

  function bindGuideDirectoryLinks() {
    $('.l-home-guides a').on('click', function() {
      clickTracker.sendEvent('guides directory', $(this).attr('href'));
    });
  }

  function bindAboutServiceLinks() {
    $('.l-home-about a').on('click', function() {
      clickTracker.sendEvent('about the service', $(this).attr('href'));
    });
  }

  function bindBreadcrumbLinks() {
    $('.breadcrumbs a').on('click', function() {
      clickTracker.sendEvent('breadcrumb', $(this).attr('href'));
    });
  }

  function bindContentLinks() {
    $('article a').on('click', function() {
      clickTracker.sendEvent('content', $(this).attr('href'));
    });
  }

  function bindTableLinks() {
    $('.ga-options-table a').on('click', function() {
      clickTracker.sendEvent('options table', $(this).attr('href'));
    });
  }

  function bindPagerLinks() {
    $('.pager a').on('click', function() {
      clickTracker.sendEvent('pager', $(this).attr('href'));
    });
  }

  function bindJourneySidebarLinks() {
    $('.ga-journey-sidebar a').on('click', function() {
      clickTracker.sendEvent('journey sidebar', $(this).attr('href'));
    });
  }

  function bindJourneyElsewhereLinks() {
    $('.ga-elsewhere-sidebar a').on('click', function() {
      clickTracker.sendEvent('elsewhere sidebar', $(this).attr('href'));
    });
  }

  PWPG.clickTracker = clickTracker;

})(jQuery);
