/* global moment */
(function() {
  'use strict';

  class SlotPickerDay {
    constructor(day, month) {
      this.templateId = '#slot-picker-calendar-day-template';
      this.templateTimeSlotId = '#slot-picker-calendar-time';
      this.$times = $('.js-slot-picker-times');
      this.day = day;
      this.month = month;

      this.dayTemplate = this.getTemplate(this.templateId);
      this.timeTemplate = this.getTemplate(this.templateTimeSlotId);
      this.render();
    }

    getTemplate(id) {
      return $(id).html();
    }

    getAvailableTimes() {
      return window.availability[this.day.format('YYYY-MM-DD')];
    }

    render() {
      let $day;

      this.dayTemplate = this.replaceVars({
        'day_number': this.day.date(),
        'day': this.day.format('dddd, D MMMM YYYY')
      }, this.dayTemplate);

      $day = $(this.dayTemplate);

      $day.on('click', this.handleDayClick.bind(this));

      if (this.month.availableDates.indexOf(this.day.format('YYYY-MM-DD')) === -1) {
       $day.find('.slot-picker-calendar__action')
         .addClass('slot-picker-calendar__action--busy')
         .prop('disabled', 'true');
      }

      return $day;
    }

    handleDayClick(event) {
      this.renderTimeSlots($(event.currentTarget));
    }

    renderTimeSlots($day) {
      const times = this.getAvailableTimes();
      let output = [];

      $.each(times, (index, time) => {
        output.push($(this.replaceVars({
          'time': time
        }, this.timeTemplate)));
      });

      console.log(output);

      this.$times.html(output);
    }

    replaceVars(keyVars, string) {
      for (let key in keyVars) {
        const regexp = new RegExp(`{${key}}`, 'g');
        string = string.replace(regexp, keyVars[key]);
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
        output.push(new SlotPickerDay(moment(day), this).render());
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
