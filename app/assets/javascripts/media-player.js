//= require jquery-ui/ui/jquery.ui.core.js
//= require jquery-ui/ui/jquery.ui.widget.js
//= require jquery-ui/ui/jquery.ui.mouse.js
//= require jquery-ui/ui/jquery.ui.slider.js
//= require jquery/jquery.player.min.js

(function($) {
    'use strict';

    var mediaPlayer = {
        init: function() {

          // Find all links to videos on youtube
          var $ytLinks = $('a[href*="https://www.youtube.com/watch"]');

          // Create players for our youtube links
          $.each($ytLinks, function(i) {
              var $holder = $('<span />');
              $(this).parent().replaceWith($holder);

              // Find the captions file if it exists
              var $captionLink = $(this).siblings('.captions');

              // Work out if we have captions or not
              var captionFile = $($captionLink).length > 0 ? $($captionLink).attr('href') : null;

              // Ensure that we extract the last part of the youtube link (the video id)
              // and pass it to the player() method
              var link = $(this).attr('href').split('=')[1];

              // Initialise the player
              $holder.player({
                  id: 'yt' + i,
                  media: link,
                  captions: captionFile,
                  captionsOn: false
              });
          });

          this.trackUsage();
      },
      trackUsage: function() {
        var player = window.NOMENSA.player.PlayerDaemon.getPlayer('yt0');
        var youTubeId = player.config.media;
        var hasStarted = 0;
        var timer;
        var recordOfProgress = {
          10: false,
          20: false,
          30: false,
          40: false,
          50: false,
          60: false,
          70: false,
          80: false,
          90: false
        };

        player.onPlayerStateChange = function(state) {

          // track that video has started
          if ((hasStarted === 0) && (state === player.state.playing)) {
            dataLayer.push({
              event: 'youtube',
              eventCategory: 'youtube',
              eventAction: 'started',
              eventLabel: youTubeId
            });
            hasStarted = 1;
          }

          // track that video has ended
          if (state === player.state.ended) {
            dataLayer.push({
              event: 'youtube',
              eventCategory: 'youtube',
              eventAction: 'ended',
              eventLabel: youTubeId
            });
          }

          // progress in 10% increments
          if (state === player.state.playing) {

            timer = setInterval(function() {
              var currentTime = player.getPlayer().getCurrentTime();
              var duration = player.getPlayer().getDuration();
              var percentagePlayed = currentTime / duration * 100;

              for (var prop in recordOfProgress) {
                if (prop <= percentagePlayed && recordOfProgress[prop] === false) {
                  dataLayer.push({
                    event: 'youtube',
                    eventCategory: 'youtube',
                    eventAction: prop + '% played',
                    eventLabel: youTubeId
                  });
                  recordOfProgress[prop] = true;
                }
              }
            }, 1000);

          } else {
            clearInterval(timer);
          }

          // re-implement button state code which was lost by overriding onPlayerStateChange()
          if (state === player.state.playing) {
            player.$html.find('.play').removeClass('play').addClass('pause').text('Pause');
          }

          // make sure button state is correct when paused and when video ends
          if (state === player.state.paused || state === player.state.ended) {
            player.$html.find('.pause').removeClass('pause').addClass('play').text('Play');
          }
        };
      }
    };

    window.PWPG = window.PWPG || {};
    window.PWPG.mediaPlayer = mediaPlayer;

})(jQuery);
