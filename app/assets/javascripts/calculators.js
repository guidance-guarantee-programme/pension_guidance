(function($) {
  'use strict';

  var calculators = {
    scrollSpeed: 700,
    experiment: window.location.hash ? window.location.hash.substr(1) : '',

    init: function() {
      this._initDOM();
      this._addListeners();

      if (this.experiment) {
        $(window).on('hashchange', function() {
          window.location.reload();
        });
      }
    },

    submitForm: function() {
      var $form = this.$calculator.find('form');
      var formData = $form.serialize();

      formData += '&experiment=' + this.experiment;

      this._toggleLoading(true);
      return $.get($form.attr('action'), formData);
    },

    updateEstimate: function(data) {
      this.$calculator.removeClass('hide-from-print');
      this._refresh(data);
      this._scrollTo(this.$submitButton).then($.proxy(function() {
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

      $target.empty().html(html);
      this._cacheElements();
    },

    _initDOM: function() {
      this.$calculator = $('.js-calculator').attr('aria-live', 'polite');
      this._cacheElements();
    },

    _cacheElements: function() {
      this.$submitButton = this.$calculator.find('.js-calculate-submit');
      this.$estimate = this.$calculator.find('.js-calculator-estimate');

      if (!this.$loadingStatus || this.$loadingStatus.length < 1) {
        this.$loadingStatus = $('<span class="calculator__loading-status">Please wait...</span>').
                             insertAfter(this.$submitButton);
      }
    },

    _addListeners: function() {
      this.$calculator.on('submit', 'form', $.proxy(function(event) {
        event.preventDefault();
        this.submitForm()
          .then($.proxy(this.updateEstimate, this))
          .fail($.proxy(this.handleError, this));
      }, this));

      this.$calculator.on('click', '[data-adjuster]', $.proxy(function(event) {
        var $adjuster = $(event.currentTarget);
        var targetData = $adjuster.data('adjuster').split('|');
        var $targetElement = this.$calculator.find('#' + targetData[0]);
        var newValue = parseFloat($targetElement.data('value')) + parseFloat(targetData[1]);

        $targetElement.val(newValue);

        if (this.experiment == 'exp-buttons') {
          this.$submitButton.click();
          event.preventDefault();
        }

        if (this.experiment == 'exp-radios') {
          this._updateEstimateOnly();
        }
      }, this));
    },

    _updateEstimateOnly: function() {
      this.submitForm().then($.proxy(function(data) {
        var $empty = $('<div/>');
        var $estimate = $empty.append(data).find('#js-estimate');
        this._refresh($estimate, $('#js-estimate'));
        this._toggleLoading(false);
      }, this));
    },

    _toggleLoading: function(isLoading) {
      this.$loadingStatus[isLoading ? 'addClass' : 'removeClass']('calculator__loading-status--loading');
    },

    _scrollTo: function($el) {
      var offset = $el.offset() || {};
      var target = offset.top || 0;
      var $page = $('html, body');

      $page.on("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", function(){
        $page.stop();
      });

      return $('html, body').stop().animate({
        scrollTop: offset.top || 0
      }, this.scrollSpeed).promise().then(function() {
        $page.off("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove");
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.calculators = calculators;
})(jQuery);
