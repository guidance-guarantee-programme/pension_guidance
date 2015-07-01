/*global GOVUK, ShowHideContent */

//= require jquery/dist/jquery.min.js
//= require click-tracker.js
//= require selection-buttons.js
//= require show-hide-content.js

PWPG.clickTracker.init();

$(document).ready(function() {
  'use strict';

  // Use GOV.UK selection-buttons.js to set selected and focused states for block labels
  var $blockLabels = $('.block-label input[type="radio"], .block-label input[type="checkbox"]');
  new GOVUK.SelectionButtons($blockLabels);

  // Where .block-label uses the data-target attribute to toggle hidden content
  var toggleContent = new ShowHideContent();
  toggleContent.showHideRadioToggledContent();

  // show hidden field for selected radio button on error page
  $('.block-label input:checked').click();
});
