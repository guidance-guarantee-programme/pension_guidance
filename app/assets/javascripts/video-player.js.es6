//= require jquery-ui/ui/core.js
//= require jquery-ui/ui/widget.js
//= require jquery-ui/ui/mouse.js
//= require jquery-ui/ui/slider.js
//= require accessible.media.player/core/javascript/swfobject/swfobject.js
//= require accessible.media.player/core/javascript/browser.js
//= require accessible.media.player/core/javascript/jquery.player.js
//= require accessible.media.player/core/javascript/youtube_player.js
//= require accessible.media.player/core/javascript/mediaplayer_decorator.js

(function() {
  'use strict';

  class VideoPlayer {
    constructor() {
      this.init();
    }

    init() {
      this.enableYouTube();
    }

    enableYouTube() {
      var $yt_links = $("a[href*='http://www.youtube.com/watch'],a[href*='https://www.youtube.com/watch']");
      // Create players for our youtube links
      $.each($yt_links, function(i) {
        var $holder = $('<span />');
        $(this).replaceWith($holder);
        // Find the captions file if it exists
        var $mycaptions = $(this).siblings('.captions');
        // Work out if we have captions or not
        var captionsf = $($mycaptions).length > 0 ? $($mycaptions).attr('href') : null;
        // Ensure that we extract the last part of the youtube link (the video id)
        // and pass it to the player() method
        var link = $(this).attr('href').split("=")[1];

        var youTubeURL = (document.location.protocol + '//www.youtube.com/apiplayer?enablejsapi=1&version=3&playerapiid=');

        $holder.player({
          id:'yt'+i,
          media:link,
          captions:captionsf,
          url: youTubeURL,
          flashHeight: '252px'
        });
      });
    }
  }

  window.moj = window.moj || { Modules: {}, Helpers: {} };

  window.PWPG = window.PWPG || {};
  window.PWPG.VideoPlayer = VideoPlayer;
  new VideoPlayer()
})();
