describe('click event logger', function() {
  'use strict';

  it ('should be defined', function() {
    expect(PWPG.ClickEventLogger).toBeDefined();
  });

  it ('sends data to Google Analytics via Google Tag Manager', function() {
    var tracker;

    window.dataLayer = [];

    tracker = new PWPG.ClickEventLogger('exampleCategoryName');
    tracker.sendEvent('exampleActionLabel', 'exampleUrl');

    expect(window.dataLayer).toContain({
      'event': 'gaTriggerEvent',
      'eventCategory': 'exampleCategoryName',
      'eventAction': 'exampleActionLabel',
      'eventLabel': 'exampleUrl'
    });
  });

  it ('creates a category name based on the pathname of the page', function() {
    var pathname, tracker;

    pathname = '/';
    tracker = new PWPG.ClickEventLogger(pathname);
    expect(tracker.categoryName()).toEqual('homepage');

    pathname = '/tax';
    tracker = new PWPG.ClickEventLogger(pathname);
    expect(tracker.categoryName()).toEqual('tax');

    pathname = '/pension-pot-options';
    tracker = new PWPG.ClickEventLogger(pathname);
    expect(tracker.categoryName()).toEqual('pension-pot-options');
  });
});
