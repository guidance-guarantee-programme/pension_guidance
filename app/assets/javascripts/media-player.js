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

        }
    };

    window.PWPG = window.PWPG || {};
    window.PWPG.mediaPlayer = mediaPlayer;

})(jQuery);
