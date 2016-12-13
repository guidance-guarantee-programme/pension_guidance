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
      this.transcript = {};
      this.transcript.$toggle = $('.js-video-transcript-toggle');
      this.transcript.$content = $('.js-video-transcript');

      this.convertLinksToPlayers();
      this.enableTranscriptToggle();
    }

    convertLinksToPlayers() {
      const $yt_links = $("a[href*='http://www.youtube.com/watch'],a[href*='https://www.youtube.com/watch']");

      $.each($yt_links, (i, link) => {
        let $holder = $('<span />');

        $(link).replaceWith($holder);

        const $mycaptions = $(this).siblings('.captions'),
          captionsf = $($mycaptions).length > 0 ? $($mycaptions).attr('href') : null,
          videoId = $(link).attr('href').split("=")[1],
          youTubeURL = document.location.protocol + '//www.youtube.com/apiplayer?enablejsapi=1&version=3&playerapiid=';

        $holder.player({
          id: 'yt' + i,
          media: videoId,
          captions: captionsf,
          url: youTubeURL,
          flashHeight: '252px'
        });
      });
    }

    enableTranscriptToggle() {
      this.handleTranscriptToggle();
      this.transcript.$toggle.removeClass('visually-hidden');
      this.transcript.$toggle.on('click', this.handleTranscriptToggle.bind(this));
    }

    handleTranscriptToggle(e) {
      if (e) {
        e.preventDefault();
      }

      if (this.transcript.$content.is(':visible')) {
        this.transcript.$content.attr('aria-hidden', true).hide();
        this.transcriptToggleTextReplace('Hide', 'Show');
      } else {
        this.transcript.$content
          .attr('aria-hidden', false)
          .slideDown()
          .focus();

        this.transcriptToggleTextReplace('Show', 'Hide');
      }
    }

    transcriptToggleTextReplace(from, to) {
      this.transcript.$toggle.text(this.transcript.$toggle.text().replace(from, to));
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.VideoPlayer = VideoPlayer;

  new VideoPlayer();
})();
