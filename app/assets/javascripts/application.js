//= require jquery/dist/jquery.min.js
//= require pubsub.js
//= require govuk_toolkit
//= require checkbox-radio-init.js
//= require click-tracker.js
//= require calculators.js
//= require feedback.js
//= require disable-button.js

//= require components/BaseComponent
//= require components/Navigation
//= require components/Slider
//= require components/SlotPicker
//= require components/SlotPickerSingleTime

PWPG.clickTracker.init();
PWPG.calculators.init();
PWPG.feedback.init();

$('[data-slider]').each(function() {
  'use strict';
  var $component = $(this);
  new PWPG.Slider($component);
});

$('[data-slot-picker]').each(function() {
  'use strict';
  var $component = $(this);
  $('#hidden_telephone_appointment_step').val(2);
  new PWPG.SlotPicker($component);
});

$('[data-slot-picker-single-time]').each(function() {
  'use strict';
  var $component = $(this),
    $form = $('.js-day-picker-form');

  new PWPG.SlotPickerSingleTime($component, $form);
});

new PWPG.Navigation();
