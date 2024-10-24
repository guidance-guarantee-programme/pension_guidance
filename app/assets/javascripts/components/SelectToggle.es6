{
  'use strict';

  class SelectToggle extends PWPG.BaseComponent {
    constructor($component) {
      super($component);
      this.$select = $(this.$component.data('select'));
      this.$target = $(this.$component.data('target'));
      this.$match = this.$component.data('match').toString();

      this.bindEvents();
      this.selectChanged();
    }

    bindEvents() {
      this.$select.on('change', this.selectChanged.bind(this));
    }

    selectChanged() {
      if(this.$select.val() === this.$match)
      {
        this.$target.removeClass('js-hidden');
      }
      else
      {
        this.$target.addClass('js-hidden');
      }
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.SelectToggle = SelectToggle;
}
