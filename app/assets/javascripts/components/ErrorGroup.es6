(function() {
  'use strict';

  class ErrorGroup extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      $('.js-question').addClass('form-group-error');
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.ErrorGroup = ErrorGroup;
})();
