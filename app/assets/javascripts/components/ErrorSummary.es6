(function() {
  'use strict';

  class ErrorSummary extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      $component.focus();

      $component.find('a').on('click', (e)=> {
        e.preventDefault();
        var href = $(e.target).attr('href');
        $(href).focus();
      })
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.ErrorSummary = ErrorSummary;
})();
