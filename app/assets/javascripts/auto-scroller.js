(function() {
  'use strict';

  var autoScroller = {
    start: function() {
      if (!window.parent) {
        return;
      }

      if (!window.parent.postMessage) {
        return;
      }

      $(function() {
        // this only works because the parent in AEM receives the message
        // and has code to act on it

        var disableScrollToTopMeta = document.querySelector(
          'meta[name="disable_scroll_to_top"]'
        );
        var isScrollToTopDisabled = !!(
          disableScrollToTopMeta && disableScrollToTopMeta.content === 'true'
        );

        if (!isScrollToTopDisabled) {
          window.parent.postMessage({ scrollToTop: true }, '*');
        }
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.autoScroller = autoScroller;
})(jQuery);
