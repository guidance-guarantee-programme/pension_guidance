(function($) {
  'use strict';

  var feedback = {
    init: function() {
      this.$feedback = $('.js-feedback');

      if (this.$feedback.length) {
        this.listeners();
      }
    },

    listeners: function() {
      this.$feedback.on('submit', 'form', $.proxy(function(e) {
        this.$form = this.$feedback.find('.js-feedback-form');

        var formData = this.$form.serialize();
        var action = this.$form.attr('action');

        $.post(action, formData)
          .then($.proxy(this.handleSuccess, this))
          .fail($.proxy(this.handleError, this));

        e.preventDefault();
      }, this));

      this.$feedback.find('.js-feedback__toggle').click($.proxy(function(e) {
        this.$feedback.find('.js-feedback__content')
          .toggleClass('hide-only-with-js')
          .attr('aria-live', 'polite');

        e.preventDefault();
      }, this));
    },

    handleSuccess: function(data) {
      this.$feedback.html(data);

      setTimeout($.proxy(function() {
        this._scrollTo(this.$feedback);
      }, this), 100);
    },

    handleError: function(xhr) {
      this.$feedback.html(xhr.responseText);
    },

    _scrollTo: function($el) {
      var offset = $el.offset() || {};
      var target = offset.top || 0;
      var $page = $('html, body');

      $page.on('scroll mousedown wheel DOMMouseScroll mousewheel touchmove', function() {
        $page.stop();
      });

      return $page.animate({
        scrollTop: target
      }, this.scrollSpeed).promise().then(function() {
        $page.off('scroll mousedown wheel DOMMouseScroll mousewheel touchmove');
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.feedback = feedback;

})(jQuery);
