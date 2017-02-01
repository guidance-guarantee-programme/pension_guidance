(function() {
  'use strict';

  class SlotPicker extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      this.$months = this.$component.find('.js-slot-picker-month');
      this.$dayButtons = this.$component.find('.js-day-button');
      this.$prevMonth = this.$component.find('.js-slot-picker-prev-month');
      this.$nextMonth = this.$component.find('.js-slot-picker-next-month');

      this.selectedClass = 'slot-picker-calendar__action--selected';
      this.selectedSelector = `.${this.selectedClass}`;
      this.monthSelector = '.js-slot-picker-month';

      this.init();
    }

    init() {
      this.revealMonthButtons();
      this.selectInitialMonth();
      this.bindEvents();
    }

    revealMonthButtons() {
      this.$prevMonth.removeClass('hidden');
      this.$nextMonth.removeClass('hidden');
    }

    bindEvents() {
      this.$prevMonth.on('click', this.handlePrevClick.bind(this));
      this.$nextMonth.on('click', this.handleNextClick.bind(this));
      this.$dayButtons.on('click', this.handleDayClick.bind(this));
    }

    handleDayClick(e) {
      const $selectedButton = $(e.currentTarget),
        $currentSelectedButton = this.getSelectedButton();

      e.preventDefault();

      $currentSelectedButton
        .removeClass(this.selectedClass)
        .attr('disabled', false)
        .attr('aria-pressed', false);

      $selectedButton
        .addClass(this.selectedClass)
        .attr('disabled', true)
        .attr('aria-pressed', true);

      $.publish('slot-picker-day-selected', $selectedButton);
    }

    selectInitialMonth() {
      const $selected = this.getSelectedButton(),
        $month = $selected.parents(this.monthSelector);

      if ($selected.length) {
        this.selectMonth($month.index());
      } else {
        this.selectMonth(0);
      }
    }

    selectMonth(index) {
      this.$months.hide().eq(index).show();
      this.$component.data('currentMonthIndex', index);
    }

    handlePrevClick(e) {
      e.preventDefault();
      this.selectMonth(this.currentMonthIndex() - 1);
    }

    handleNextClick(e) {
      e.preventDefault();
      this.selectMonth(this.currentMonthIndex() + 1);
    }

    currentMonthIndex() {
      return this.$component.data('currentMonthIndex') || 0;
    }

    getSelectedButton() {
      return this.$component.find(this.selectedSelector);
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.SlotPicker = SlotPicker;
})();
