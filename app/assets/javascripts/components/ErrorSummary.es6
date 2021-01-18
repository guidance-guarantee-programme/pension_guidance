(function() {
  'use strict';

  class ErrorSummary extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      $component.focus();

      var firstError = $component.find('a');

      firstError.on('click', (e)=> {
        e.preventDefault();
        var href = $(e.target).attr('href');
        $(href).focus();
      });

      var heading = $('#question > h2');

      if (heading.length) {
        $('.js-error-message').text(firstError.text());

        firstError.text(`${heading.text()} – ${firstError.text()}`);
      }
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.ErrorSummary = ErrorSummary;
})();
