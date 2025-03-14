//= require jquery/dist/jquery.min.js
//= require pubsub.js
//= require govuk_toolkit
//= stub govuk/selection-buttons
//= require click-tracker.js
//= require calculators.js
//= require auto-scroller.js
//= require feedback.js
//= require disable-button.js
//= require moment

//= require components/BaseComponent
//= require components/Navigation
//= require components/Slider
//= require components/SlotPicker
//= require components/SlotPickerSingleTime
//= require components/CharacterLimit
//= require components/ErrorSummary
//= require components/CustomerAge
//= require components/SelectToggle

PWPG.clickTracker.init();
PWPG.calculators.init();
PWPG.feedback.init();

$('[data-error-summary]').each(function() {
  'use strict';
  var $component = $(this);
  new PWPG.ErrorSummary($component);
});

$('[data-slider]').each(function() {
  'use strict';
  var $component = $(this);
  new PWPG.Slider($component);
});

$('[data-slot-picker]').each(function() {
  'use strict';
  var $component = $(this);

  $('#hidden_telephone_appointment_step, #hidden_booking_step, #hidden_nudge_appointment_step').val(2);

  new PWPG.SlotPicker($component);
});

$('[data-slot-picker-single-time]').each(function() {
  'use strict';
  var $component = $(this),
    $form = $('.js-day-picker-form');

  new PWPG.SlotPickerSingleTime($component, $form);
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

$('[data-radio-toggle], [data-checkbox-toggle]').each(function() {
  'use strict';

  var $component = $(this);
  new GOVUK.ShowHideContent().init($component); // jshint ignore:line
});

$('[data-customer-age]').each(function() {
  'use strict';

  var $component = $(this);
  new PWPG.CustomerAge($component);
});

$('[data-select-toggle]').each(function() {
  'use strict';

  var $component = $(this);
  new PWPG.SelectToggle($component);
});
