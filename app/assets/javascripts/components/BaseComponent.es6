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

    debounce(func, wait, immediate) {
      let timeout;

      return () => {
        const context = this,
          args = arguments,
          later = () => {
            timeout = null;
            if (!immediate) {
              func.apply(context, args);
            }
          },
          callNow = immediate && !timeout;

        clearTimeout(timeout);

        timeout = setTimeout(later, wait);

        if (callNow) {
          func.apply(context, args);
        }
      };
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.BaseComponent = BaseComponent;

})();
