//= require jquery/dist/jquery.min.js
//= require govuk_toolkit
//= require checkbox-radio-init.js
//= require click-tracker.js
//= require mobile-nav-toggler.js
//= require calculators.js
//= require feedback.js
//= require disable-button.js
//= require scroll-to.js

//= require components/BaseComponent
//= require components/Slider

PWPG.clickTracker.init();
PWPG.mobileNavToggler.init();
PWPG.calculators.init();
PWPG.feedback.init();

$('[data-slider]').each(function() {
  'use strict';
  var $component = $(this);
  new PWPG.Slider($component);
});
