describe('click event logger', function() {
  'use strict';

  it ('should be defined', function() {
    expect(PWPG.ClickEventLogger).toBeDefined();
  });

  it ('sends data to Google Analytics via Google Tag Manager', function() {
    var tracker;

    window.dataLayer = [];

    tracker = new PWPG.ClickEventLogger();
    tracker.sendEvent('exampleActionLabel', 'exampleUrl');

    expect(window.dataLayer).toContain({
      'event': 'gaTriggerEvent',
      'eventCategory': jasmine.any(String),
      'eventAction': 'exampleActionLabel',
      'eventLabel': 'exampleUrl'
    });
  });

  it ('creates a category name based on the pathname of the page', function() {
    var tracker, expectedCategoryName;

    expectedCategoryName = 'Clicks on ' + window.location.pathname;

    tracker = new PWPG.ClickEventLogger();
    tracker.sendEvent('exampleActionLabel', 'exampleUrl');

    expect(window.dataLayer).toContain({
      'event': jasmine.any(String),
      'eventCategory': expectedCategoryName,
      'eventAction': jasmine.any(String),
      'eventLabel': jasmine.any(String)
    });
  });
});
