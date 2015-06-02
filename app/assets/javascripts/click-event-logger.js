(function() {
  'use strict';

  var clickEventLogger = function ClickEventLogger() {
    var categoryName = 'Clicks on ' + window.location.pathname;

    this.sendEvent = function SendEvent(actionLabel, url) {
      window.dataLayer.push({
        'event': 'gaTriggerEvent',
        'eventCategory': categoryName,
        'eventAction': actionLabel,
        'eventLabel': url
      });
    };
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.ClickEventLogger = clickEventLogger;

})();
