(function($) {
  'use strict';

  var calculators = {
    scrollSpeed: 700,

    init: function() {
      this._initDOM();
      this._addListeners();
    },

    submitForm: function() {
      var $form = this.$calculator.find('form');
      this._toggleLoading(true);
      return $.get($form.attr('action'), $form.serialize());
    },

    updateResults: function(data) {
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

    _refresh: function(html) {
      this.$calculator.empty().html(html);
      this._cacheElements();
    },

    _initDOM: function() {
      this.$calculator = $('.js-calculator').attr('aria-live', 'polite');
      this._cacheElements();
    },

    _cacheElements: function() {
      this.$submitButton = this.$calculator.find('.js-calculate-submit');
      this.$results = this.$calculator.find('.js-calculator-result');
      this.$loadingStatus = $('<span class="calculator__loading-status">Please wait...</span>').
                           insertAfter(this.$submitButton);
    },

    _addListeners: function() {
      this.$calculator.on('submit', 'form', $.proxy(function(event) {
        event.preventDefault();
        this.submitForm()
          .then($.proxy(this.updateResults, this))
          .fail($.proxy(this.handleError, this));
      }, this));
    },

    _toggleLoading: function(isLoading) {
      this.$loadingStatus[isLoading ? 'addClass' : 'removeClass']('calculator__loading-status--loading');
    },

    _scrollTo: function($el) {
      var offset = $el.offset() || {};
      return $('html, body').animate({
        scrollTop: offset.top || 0
      }, this.scrollSpeed).promise();
    }
  };

  window.PWPG = window.PWPG || {};
  window.PWPG.calculators = calculators;
})(jQuery);
