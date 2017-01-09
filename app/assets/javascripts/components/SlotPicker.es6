/* global moment */
(function() {
  'use strict';

  class SlotPickerDay {
    constructor(day, month) {
      this.templateId = '#slot-picker-calendar-day-template';
      this.day = day;
      this.month = month;

      this.template = this.getTemplate();
      this.render();
    }

    getTemplate() {
      return $(this.templateId).html();
    }

    render() {
      this.template = this.replaceVars({
        '{day_number}': this.day.date(),
        '{day}': this.day.format('dddd, D MMMM YYYY')
      }, this.template);

      const $day = $(this.template);

      if (this.month.availableDates.indexOf(this.day.format('YYYY-MM-DD')) === -1) {
       $day.find('.slot-picker-calendar__action').addClass('slot-picker-calendar__action--busy');
       $day.find('.slot-picker-calendar__action').prop('disabled', 'true');
      }

      return $day;
    }

    replaceVars(keyVars, string) {
      for (let key in keyVars) {
        string = string.replace(key, keyVars[key]);
      }

      return string;
    }
  }

  class SlotPickerMonth {
    constructor(calendar) {
      this.calendar = calendar;
      this.calendar.$container.find('.slot-picker__next-month').text(this.calendar.nextMonth.format('MMMM'));
      this.calendar.$container.find('.slot-picker-calendar').html('');
      this.availableDates = this.getAvailableDates();
    }

    getAvailableDates() {
      let availableDates = [];

      $.each(window.availability, function(date) {
        availableDates.push(date);
      });

      return availableDates;
    }

    render() {
      this.createFauxDays();
      this.createDays();
    }

    createFauxDays() {
      const template = $('#slot-picker-calendar-faux-day-template').html(),
        firstOfMonthDayOfWeek = this.calendar.startOfDisplayedMonth.day();
      let fauxDaySize;

      if (firstOfMonthDayOfWeek === 1) {
        return;
      }

      if (firstOfMonthDayOfWeek === 0) {
        fauxDaySize = 6;
      } else {
        fauxDaySize = firstOfMonthDayOfWeek - 1;
      }

      this.calendar.$container.find('.slot-picker-calendar').html($(template).css('flex-basis', `${(100/7) * fauxDaySize}%`));
    }

    createDays() {
      let output = [];

      const start = moment(this.calendar.startOfDisplayedMonth),
        end = moment(this.calendar.endOfDisplayedMonth);

      for (let day = moment(start); day.isBefore(end); day.add(1, 'days')) {
        output.push(new SlotPickerDay(day, this).render());
      }

      this.calendar.$container.find('.js-slot-picker-calendar').append(output);
    }
  }

  class SlotPicker {
    constructor($component) {
      this.$container = $('.js-slot-picker-calendar-container');
      this.$slotPicker = $component;
      this.setDates(this.$slotPicker.data('date'));
      new SlotPickerMonth(this).render();
      this.bindEvents();
    }

    setDates(date = this.nextMonth) {
      this.currentDate = moment(date).startOf('day');
      this.startOfDisplayedMonth = moment(this.currentDate).startOf('month');
      this.endOfDisplayedMonth = moment(this.currentDate).endOf('month');
      this.nextMonth = moment(this.currentDate).add(1, 'month').startOf('month').startOf('day');
    }

    bindEvents() {
      this.$container.on('click', '.slot-picker__next-month', this.handleNextMonth.bind(this));
    }

    handleNextMonth(e) {
      e.preventDefault();
      this.setDates();
      new SlotPickerMonth(this).render();
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.SlotPicker = SlotPicker;
})();
