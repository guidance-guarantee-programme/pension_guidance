(function() {
  'use strict';

  class Navigation extends PWPG.BaseComponent {
    constructor($component) {
      super($component);
      this.init();
    }

    init() {
      this.$trigger = $('.js-nav-toggler');
      this.$target = $('.js-nav');
      this.mobileSize = 'mobile';

      this.setNavigationHiddenStatus();
      this.bindEvents();
    }

    getPageSize() {
      const el = window.getComputedStyle(this.$component[0], ':after');

      return el ? el.getPropertyValue('content') : this.mobileSize;
    }

    setNavigationHiddenStatus() {
      this.$target.attr('aria-hidden', this.getPageSize().indexOf(this.mobileSize) > -1 ? true : false);
    }

    bindEvents() {
      $(window).on('resize', this.debounce(this.setNavigationHiddenStatus.bind(this), 50));

      this.$trigger.on('click', this.handleClick.bind(this));
    }

    handleClick(e) {
      e.preventDefault();

      if (this.$target.hasClass('active')) {
        this.$target.removeClass('active');
        this.$target.attr('aria-hidden', true);
        this.$trigger.attr('aria-expanded', false);
      } else {
        this.$target.addClass('active');
        this.$target.attr('aria-hidden', false);
        this.$trigger.attr('aria-expanded', true);
        this.$target.after('<span></span>');
      }
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.Navigation = Navigation;
})();
