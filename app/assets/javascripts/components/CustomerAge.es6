/* global moment */
{
  'use strict';

  class CustomerAge extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      this.$day = this.$component.find('.js-dob-day');
      this.$month = this.$component.find('.js-dob-month');
      this.$year = this.$component.find('.js-dob-year');
      this.$appointment = moment(this.$component.data('appointment-date'));
      this.$output = $(`#${this.$component.data('output-id')}`);

      this.bindEvents();
    }

    bindEvents() {
      this.$day.on('change input', this.renderCustomerAge.bind(this));
      this.$month.on('change input', this.renderCustomerAge.bind(this));
      this.$year.on('change input', this.renderCustomerAge.bind(this));
      this.renderCustomerAge();
    }

    padNumber(val) {
      return (`00${val}`).substr(-2, 2);
    }

    renderCustomerAge() {
      let day = parseInt(this.$day.val()),
        month = parseInt(this.$month.val()),
        year = parseInt(this.$year.val()),
        today = moment(),
        inputDate = null,
        age = null;

      if (!day || !month || !year || year < 1900 || year >= today.format('Y')) {
        return;
      }

      day = this.padNumber(day);
      month = this.padNumber(month);
      inputDate = moment(`${year}-${month}-${day}`);

      age = this.$appointment.year() - inputDate.year();

      if (this.$appointment < inputDate.set('year', moment().year())) {
        age -= 1;
      }

      if (age < 50) {
        this.$output.removeClass('js-hidden');
      } else {
        this.$output.addClass('js-hidden');
      }
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.CustomerAge = CustomerAge;
}
