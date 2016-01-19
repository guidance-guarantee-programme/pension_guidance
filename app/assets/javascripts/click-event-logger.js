(function() {
  'use strict';

  var clickEventCache = {};

  function categoryName() {
    return 'Clicks on ' + window.location.pathname;
  }

  function generateKeyForCache(actionLabel, url) {
    return '' + actionLabel + url;
  }

  var clickEventLogger = {
    sendEvent: function(actionLabel, url) {
      window.dataLayer.push({
        'event': 'gaTriggerEvent',
        'eventCategory': categoryName(),
        'eventAction': actionLabel,
        'eventLabel': url
      });
    },

    sendEventOnlyOnce: function(actionLabel, url) {
      var keyForCache = generateKeyForCache(actionLabel, url);

      if (!!!clickEventCache[keyForCache]) {
        clickEventCache[keyForCache] = true;
        return this.sendEvent(actionLabel, url);
      }
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.clickEventLogger = clickEventLogger;

})();
