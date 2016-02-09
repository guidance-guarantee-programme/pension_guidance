(function($) {
  'use strict';

  var calculators = {
    scrollSpeed: 700,
    experiment: window.location.hash ? window.location.hash.substr(1) : '',
    request: null,

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

      if (this.request) {
        this.request.abort();
      }

      this.request = $.get($form.attr('action'), formData);

      return this.request;
    },

    updateEstimate: function(data) {
      this.$calculator.removeClass('hide-from-print');
      this._refresh(data);

      if (this.experiment == 'exp-slider') {
        $("input[type='range']", this.$calculator).change();
      }

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

      $target.empty().html(html).find('#js-estimate').removeClass('highlight').addClass('highlight');

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

      this.$calculator.on('click input change', '[data-adjuster]', $.proxy(function(event) {
        var $adjuster = $(event.currentTarget);
        var targetData = $adjuster.data('adjuster').split('|');
        var $targetElement = this.$calculator.find('#' + targetData[0]);
        var targetValue = targetData[1];
        var newValue = 0;

        // 'x' means we have a dynamic value to work out somewhere
        if (targetValue !== 'x') {
          newValue = parseFloat($targetElement.data('value')) + parseFloat(targetValue);
          $targetElement.val(newValue);
        }

        if (this.experiment == 'exp-buttons') {
          this.$submitButton.click();
          event.preventDefault();
        }

        if (this.experiment == 'exp-radios') {
          this._updateEstimateOnly();
        }

        if (this.experiment == 'exp-slider') {
          var newPoint, newPlace, newWidth, offset, width;
          var buffer = null;
          var output = $adjuster.next("output");

          // Measure width of range input
          width = $adjuster.width();

          // Figure out placement percentage between left and right of input
          newPoint = ($adjuster.val() - $adjuster.attr("min")) / ($adjuster.attr("max") - $adjuster.attr("min"));

          // Prevent bubble from going beyond left or right (unsupported browsers)
          if (newPoint < 0) { newPlace = 0; }
          else if (newPoint > 1) { newPlace = width; }
          else { newPlace = width * newPoint; }

          output.text('£' + $adjuster.val());

          newWidth = output.outerWidth();
          output.css({
            left: newPlace,
            marginLeft: -(newWidth / 2)
          });

          // update form fields and resubmit
          clearTimeout(buffer);
          buffer = setTimeout($.proxy(function() {
            newValue = parseFloat($targetElement.data('value')) + parseFloat($adjuster.val());
            $targetElement.val(newValue);
            this._updateEstimateOnly();
          }, this), 150);
        }
      }, this));
    },

    _updateEstimateOnly: function() {
      this.submitForm().then($.proxy(function(data) {
        var $empty = $('<div/>');
        var $estimate = $empty.append(data).find('#js-estimate');
        this._refresh($estimate, $('#js-estimate'));

        this._scrollTo(this.$submitButton).then($.proxy(function() {
          this._toggleLoading(false);
        }, this));

      }, this));
    },

    _toggleLoading: function(isLoading) {
      this.$loadingStatus[isLoading ? 'addClass' : 'removeClass']('calculator__loading-status--loading');
    },

    _scrollTo: function($el) {
      var offset = $el.offset() || {};
      var target = offset.top || 0;
      var $page = $('html, body');

      $page.on("scroll mousedown wheel DOMMouseScroll mousewheel touchmove", function(){
        $page.stop();
      });

      return $('html, body').animate({
        scrollTop: target
      }, this.scrollSpeed).promise().then(function() {
        $page.off("scroll mousedown wheel DOMMouseScroll mousewheel touchmove");
      });
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.calculators = calculators;
})(jQuery);
