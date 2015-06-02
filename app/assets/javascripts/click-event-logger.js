(function() {
  'use strict';

  var defaultCategoryName = 'homepage';

  var clickEventLogger = function ClickEventLogger(pathname) {
    var categoryName;

    pathname = pathname || window.location.pathname;
    categoryName = pathname.replace('/', '') || defaultCategoryName;

    this.categoryName = function CategoryName() {
      return categoryName;
    };

    this.sendEvent = function SendEvent(actionLabel, url) {
      ga('send', 'event', this.categoryName(), actionLabel, url);
    };
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.ClickEventLogger = clickEventLogger;

})();
