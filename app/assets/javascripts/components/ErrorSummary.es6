(function() {
  'use strict';

  class ErrorSummary extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      this.$component.focus();
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.ErrorSummary = ErrorSummary;
})();
