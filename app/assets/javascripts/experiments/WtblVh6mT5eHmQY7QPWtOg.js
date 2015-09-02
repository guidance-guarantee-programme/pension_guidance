/**
 * Video Promo Experiment
 */

(function($) {
  'use strict';

  var experiment = {
    variations: [
      function() {
        if (window.location.pathname == '/take-whole-pot') {
            $('.js-video').show();
            experiment.setCookie('pwnumber', '0800 8021 074');
        } else {
            experiment.setCallCentreNumber();
        }
      },

      function() {
        if (window.location.pathname == '/take-whole-pot') {
            $('.js-video').hide();
            experiment.setCookie('pwnumber', '0800 8021 064');
        } else {
            experiment.setCallCentreNumber();
        }
      }
    ],

    setCookie: function(name, value) {
        document.cookie = name + '=' + value + '; ';
        document.cookie += 'expires=Mon, 05 Oct 2015 17:00:00 UTC';
    },

    getCookie: function(cname) {
        var name = cname + '=';
        var cookies = document.cookie.split(';');

        for (var i = 0; i < cookies.length; i++) {
            var c = cookies[i];
            while (c.charAt(0) == ' ') c = c.substring(1);
            if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
        }

        return null;
    },

    setCallCentreNumber: function() {
      var cookie = experiment.getCookie('pwnumber');

      if (cookie != null) {
        $('#phone').text(cookie);
      }
    },

    init: function(variation) {
      $(document).ready(this.variations[variation]);
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.experiment = experiment;

})(jQuery);
