/* global moment */

{
  'use strict';

  class SlotPicker {
    constructor() {
      this.$slotPicker = $('.js-slot-picker');
      this.setDates(this.$slotPicker.data('date'));
      this.$calendarContainer = $('.js-slot-picker-calendar-container');
      this.templates = {
        'calendar': '#slot-picker-calendar-template',
        'fauxDay': '#slot-picker-calendar-faux-day-template',
        'day': '#slot-picker-calendar-day-template'
      };

      this.getTemplates();
      this.createCalendar();
      this.bindEvents();
    }

    setDates(date = this.nextMonth) {
      this.currentDate = moment(date).startOf('day');
      this.startOfDisplayedMonth = moment(this.currentDate).startOf('month');
      this.endOfDisplayedMonth = moment(this.currentDate).endOf('month');
      this.nextMonth = moment(this.currentDate).add(1, 'month').startOf('month').startOf('day');
    }

    bindEvents() {
      this.$calendarContainer.on('click', '.slot-picker__next-month', this.handleNextMonth.bind(this));
    }

    handleNextMonth(e) {
      e.preventDefault();
      this.setDates();
      this.createCalendar();
    }

    getTemplates() {
      for(let template in this.templates) {
        this.templates[template] = $(this.templates[template]).html();
      }
    }

    createCalendar() {
      this.$calendarContainer.html(this.templates.calendar.replace('{month}', this.currentDate.format('MMMM')));
      this.$calendarContainer.find('.slot-picker__next-month').text(this.nextMonth.format('MMMM'));
      this.createFauxDays();
      this.createDays();
    }

    createFauxDays() {
      const firstOfMonthDayOfWeek = this.startOfDisplayedMonth.day();
      let fauxDaySize;

      if (firstOfMonthDayOfWeek === 1) {
        return;
      }

      if (firstOfMonthDayOfWeek === 0) {
        fauxDaySize = 6;
      } else {
        fauxDaySize = firstOfMonthDayOfWeek - 1;
      }

      this.$calendarContainer.find('.slot-picker-calendar').html($(this.templates.fauxDay).css('flex-basis', `${(100/7) * fauxDaySize}%`));
    }

    createDays() {
      let output = [],
       day;

      const start = moment(this.startOfDisplayedMonth),
        end = moment(this.endOfDisplayedMonth);

      for (let m = moment(start); m.isBefore(end); m.add(1, 'days')) {
        day = this.templates.day.replace('{day_number}', m.date());
        day = day.replace('{day}', m.format('dddd, D MMMM YYYY'));
        let $day = $(day);

        if (m.isBefore(this.currentDate)) {
          $day.find('.slot-picker-calendar__action').addClass('slot-picker-calendar__action--busy');
          $day.find('.slot-picker-calendar__action').prop('disabled', 'true');
        }

        output.push($day);
      }

      this.$calendarContainer.find('.slot-picker-calendar').append(output);
    }
  }

  new SlotPicker();
}
