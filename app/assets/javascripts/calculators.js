(function($) {
  'use strict';

  var calculators = {
    scrollSpeed: 700,
    request: null,

    init: function() {
      this._initDOM();
      this._addListeners();
    },

    submitForm: function() {
      var $form = this.$calculator.find('form');
      this._toggleLoading(true);

      if (this.request && typeof this.request.abort === 'function') {
        this.request.abort();
      }

      this.request = $.get($form.attr('action'), $form.serialize());

      return this.request;
    },

    updateEstimate: function(data) {
      this.$calculator.removeClass('hide-from-print');
      this._refresh(data);
      this._sliders();
      this._scrollTo(this.$scrollTarget).then($.proxy(function() {
        this._toggleLoading(false);
      }, this));
    },

    handleError: function(xhr) {
      this._refresh(xhr.responseText);
      this._scrollTo(this.$calculator).then($.proxy(function() {
        this._toggleLoading(false);
      }, this));
    },

    _refresh: function(html, $partial) {
      var $target = this.$calculator;

      if ($partial) {
        $target = $partial;
      }

      $target.empty().html(html).find('.calculator__highlight').removeClass('highlight').addClass('highlight');

      this._cacheElements();
    },

    _initDOM: function() {
      this.$calculator = $('.js-calculator').attr('aria-live', 'polite');
      this._cacheElements();
    },

    _cacheElements: function() {
      var $customScrollTarget = this.$calculator.find('.js-scroll-target');

      this.$submitButton = this.$calculator.find('.js-calculate-submit');
      this.$estimate = this.$calculator.find('.js-calculator-estimate');

      if (this.$loadingStatus) {
        this.$loadingStatus.remove();
      }

      this.$loadingMessage = this.$calculator.find('.js-calculator-form').data('loading-message');
      this.$loadingStatus = $('<span class="calculator__loading-status">' +
                              this.$loadingMessage +
                              '...</span>');
      this.$loadingStatus.insertAfter(this.$submitButton);
      this.$scrollTarget = this.$submitButton;

      if ($customScrollTarget.length) {
        this.$scrollTarget = $customScrollTarget;
      }
    },

    _addListeners: function() {
      this.$calculator.on('submit', 'form', $.proxy(function(event) {
        event.preventDefault();
        this.submitForm()
          .then($.proxy(this.updateEstimate, this))
          .fail($.proxy(this.handleError, this));
      }, this));
    },

    _updateEstimateOnly: function() {
      this.submitForm().then($.proxy(function(data) {
        var $empty = $('<div/>');
        var $estimate = $empty.append(data).find('#js-estimate');
        this._refresh($estimate, $('#js-estimate'));

        this._scrollTo(this.$scrollTarget).then($.proxy(function() {
          this._toggleLoading(false);
        }, this));

      }, this));
    },

    _toggleLoading: function(isLoading) {
      this.$loadingStatus[isLoading ? 'addClass' : 'removeClass']('calculator__loading-status--loading');
    },

    _sliders: function() {
      if ($('#slider').length) {
        var slider = new PWPG.Slider($('#slider'));
        var $target = $($('#slider').attr('data-target'));
        var buffer;

        slider.$textInput.on('change keyup', $.proxy(function() {
          clearTimeout(buffer);

          buffer = setTimeout($.proxy(function() {
            $target.val(slider.$textInput.val());
            this._updateEstimateOnly();
          }, this), 200);

        }, this));
      }
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
  window.PWPG.calculators = calculators;
})(jQuery);
