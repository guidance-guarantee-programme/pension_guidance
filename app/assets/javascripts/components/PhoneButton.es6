(function() {
  'use strict';

  class PhoneButton extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      this.init();
    }

    init() {
      $.get('/agent', (data, text, request) => {
        this.$component.attr('target', '_blank');
        this.$component.attr('href', request.getResponseHeader('Location'));
      });
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.PhoneButton = PhoneButton;
})();
