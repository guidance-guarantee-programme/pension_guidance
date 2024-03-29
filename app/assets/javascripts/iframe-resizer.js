(function() {
  'use strict';

  var timer, frameDefaultOverflow;
  var minFrameHeight = 250;
  var targetOrigin = '*';
  var msgPrefix = 'MASRESIZE-';

  var iframeResizer = {
    start: function() {
      if (!window.postMessage) {
        return;
      }

      if ( !window.getComputedStyle) {
        window.getComputedStyle = function(e) {
          return e.currentStyle;
        };
      }

      var currentHeight = 0,
        bodyNode = document.body,
        frameTopMargin,
        frameBtmMargin;

      frameDefaultOverflow = window.getComputedStyle(bodyNode).overflow;
      document.documentElement.style.overflow = 'hidden';
      frameTopMargin = parseInt(window.getComputedStyle(bodyNode).marginTop, 16);
      frameBtmMargin = parseInt(window.getComputedStyle(bodyNode).marginBottom, 16);

      timer = setInterval(function() {
        var documentHeight = Math.max(
          frameTopMargin + frameBtmMargin + bodyNode.scrollHeight,
          minFrameHeight
        );
        if (documentHeight !== currentHeight) {
          window.parent.postMessage(msgPrefix + documentHeight, targetOrigin);
          currentHeight = documentHeight;
        }
      }, 200);
    },
    stop: function() {
      clearInterval(timer);
      document.documentElement.style.overflow = frameDefaultOverflow;
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.iframeResizer = iframeResizer;

})(jQuery);
