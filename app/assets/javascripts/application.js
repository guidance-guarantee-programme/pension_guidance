//= require jquery/dist/jquery.min.js
//= require mailgun-validator-jquery
//= require pubsub.js
//= require govuk_toolkit
//= stub govuk/selection-buttons
//= require click-tracker.js
//= require calculators.js
//= require feedback.js
//= require disable-button.js

//= require components/BaseComponent
//= require components/Navigation
//= require components/Slider
//= require components/SlotPicker
//= require components/SlotPickerSingleTime
//= require components/EmailValidation
//= require components/CharacterLimit

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

  $('#hidden_telephone_appointment_step, #hidden_booking_step').val(2);

  new PWPG.SlotPicker($component);
});

$('[data-slot-picker-single-time]').each(function() {
  'use strict';
  var $component = $(this),
    $form = $('.js-day-picker-form');

  new PWPG.SlotPickerSingleTime($component, $form);
});

$('[data-email-validation]').each(function() {
  'use strict';

  var $component = $(this);

  new PWPG.EmailValidation($component);
});

$('[data-navigation]').each(function() {
  'use strict';

  var $component = $(this);

  new PWPG.Navigation($component);
});

$('[data-character-limit]').each(function() {
  'use strict';

  var $component = $(this);

  new PWPG.CharacterLimit($component);
});
