$(document).ready(function() {
  $('.video-transcript-toggle')
    .removeClass('visuallyhidden')
    .on('click', function() {
      $($(this).attr("href")).toggle();
      return false;
    });

  var videos = $('.youtube-video--video');

  if(videos.length > 0) {
    var tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    window.onYouTubeIframeAPIReady = function() {
      $.each(videos, function (i, video) {
        new YT.Player(video, {
          height: '282',
          width: '422',
          videoId: $(video).data('id')
        });
      });
    }
  }
});
