/* global moment */
(function() {
  'use strict';

  class SlotPickerDay {
    constructor(day, month) {
      this.day = day;
      this.month = month;

      this.dateFormat = {
        'dayData': 'YYYY-MM-DD',
        'dayShort': 'D MMMM YYYY',
        'dayLong': 'dddd, D MMMM YYYY'
      };
      this.$timeSlotHeaderDate = $('.js-slot-picker-time-header-date');
      this.$times = $('.js-slot-picker-times');
      this.dayTemplate = $('#slot-picker-calendar-day-template').html();
      this.timeTemplate = $('#slot-picker-calendar-time').html();
      this.render();
    }

    getAvailableTimes() {
      return window.availability[this.day.format(this.dateFormat.dayData)];
    }

    render() {
      let $day;

      this.dayTemplate = this.replaceVars({
        'day_number': this.day.date(),
        'day': this.day.format(this.dateFormat.dayLong)
      }, this.dayTemplate);

      $day = $(this.dayTemplate);
      $day.data('day', this.day);

      if (this.month.calendar.availableDates.indexOf(this.day.format(this.dateFormat.dayData)) === -1) {
       $day.find('.slot-picker-calendar__action')
         .addClass('slot-picker-calendar__action--busy')
         .prop('disabled', 'true');
      } else {
        $day.find('button').on('click', this.handleDayClick.bind(this));
      }

      return $day;
    }

    handleDayClick(event) {
      const $button = $(event.currentTarget),
        $day = $button.parent();
      this.showDayAsSelected($button);
      this.renderTimeSlotHeader($day);
      this.renderTimeSlots($day);
    }

    showDayAsSelected($button) {
      const selectedClass = 'slot-picker-calendar__action--selected';
      this.month.calendar.$container.find(`.${selectedClass}`).removeClass(selectedClass);
      $button.addClass('slot-picker-calendar__action--selected');
    }

    renderTimeSlotHeader($day) {
      this.$timeSlotHeaderDate.html(`on ${$day.data('day').format(this.dateFormat.dayShort)}`);
    }

    renderTimeSlots($day) {
      const times = this.getAvailableTimes();
      let output = [];

      $.each(times, (index, time) => {
        output.push($(this.replaceVars({
          'time': time,
          'date': $day.data('day').format(this.dateFormat.dayData)
        }, this.timeTemplate)));
      });

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
      this.dateFormat = {
        'month': 'MMMM'
      },
      this.calendar.$container.find('.js-slot-picker-month').html(this.calendar.currentDate.format(this.dateFormat.month));
      this.calendar.$container.find('.slot-picker__prev-month').text(this.calendar.prevMonth.format(this.dateFormat.month));
      this.calendar.$container.find('.slot-picker__next-month').text(this.calendar.nextMonth.format(this.dateFormat.month));
      this.calendar.$container.find('.slot-picker-calendar').html('');
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

      this.calendar.$container.find('.slot-picker-calendar')
      .html(
        $(template).css('flex-basis', `${(100/7) * fauxDaySize}%`)
      );
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
    constructor($slotPicker) {
      this.$container = $('.js-slot-picker-calendar-container');
      this.$prevMonth = $('.js-slot-picker-prev-month');
      this.$nextMonth = $('.js-slot-picker-next-month');
      this.$slotPicker = $slotPicker;
      this.availableDates = this.getAvailableDates();

      this.setDates(this.$slotPicker.data('date'));
      this.bindEvents();
      this.render();
    }

    getAvailableDates() {
      let availableDates = [];

      $.each(window.availability, function(date) {
        availableDates.push(date);
      });

      availableDates = availableDates.sort();

      return availableDates;
    }

    getFirstAvailableDate() {
      return moment(this.availableDates[0]);
    }

    getLastAvailableDate() {
      return moment(this.availableDates.slice(-1)[0]);
    }

    setDates(date) {
      this.currentDate = moment(date).startOf('day');
      this.startOfDisplayedMonth = moment(this.currentDate).startOf('month');
      this.endOfDisplayedMonth = moment(this.currentDate).endOf('month');
      this.nextMonth = moment(this.currentDate).add(1, 'month').startOf('month').startOf('day');
      this.prevMonth = moment(this.currentDate).subtract(1, 'month').startOf('month').startOf('day');
    }

    bindEvents() {
      this.$container.on('click', '.js-slot-picker-prev-month', this.handlePrevMonth.bind(this));
      this.$container.on('click', '.js-slot-picker-next-month', this.handleNextMonth.bind(this));
    }

    handlePrevMonth(e) {
      this.handleMonthChange(e, this.prevMonth);
    }

    handleNextMonth(e) {
      this.handleMonthChange(e, this.nextMonth);
    }

    handleMonthChange(e, month) {
      e.preventDefault();
      this.setDates(month);
      this.render();
    }

    render() {
      this.$prevMonth.removeClass('slot-picker__prev-month--hide');
      this.$nextMonth.removeClass('slot-picker__next-month--hide');

      if (this.getFirstAvailableDate().format('YYYY-MM') == this.currentDate.format('YYYY-MM')) {
        this.$prevMonth.addClass('slot-picker__prev-month--hide');
      }

      if (this.getLastAvailableDate().format('YYYY-MM') == this.currentDate.format('YYYY-MM')) {
        this.$nextMonth.addClass('slot-picker__next-month--hide');
      }

      new SlotPickerMonth(this).render();
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.SlotPicker = SlotPicker;
})();
