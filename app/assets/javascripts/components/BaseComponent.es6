(function() {
  'use strict';

  class BaseComponent {
    constructor($component) {
      this.$component = $component;
    }

    checkInputSupported(type) {
      var input = document.createElement('input');
      input.setAttribute('type', type);
      return input.type == type;
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.BaseComponent = BaseComponent;

})();
