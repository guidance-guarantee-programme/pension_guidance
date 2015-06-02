(function() {
  'use strict';

  function categoryName() {
    return 'Clicks on ' + window.location.pathname;
  }

  var clickEventLogger = {
    sendEvent: function(actionLabel, url) {
      window.dataLayer.push({
        'event': 'gaTriggerEvent',
        'eventCategory': categoryName(),
        'eventAction': actionLabel,
        'eventLabel': url
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.clickEventLogger = clickEventLogger;

})();
