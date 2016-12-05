/* global GOVUK */
$(function() {
  'use strict';

  var $blockLabels = $('.block-label').find('input[type="radio"], input[type="checkbox"]');
  new GOVUK.SelectionButtons($blockLabels);

  var showHideContent = new GOVUK.ShowHideContent();
  showHideContent.init();

  GOVUK.shimLinksWithButtonRole.init();
});
