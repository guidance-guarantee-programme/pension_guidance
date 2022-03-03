//= require jasmine-jquery

jasmine.getFixtures().fixturesPath = '../../spec/javascripts/fixtures';

describe('auto scroller', function() {
  'use strict';

  beforeEach(function() {
    window.parent = {
      postMessage: function() {}
    };

    spyOn(window.parent, 'postMessage');
  });

  it('is defined', function() {
    expect(PWPG.autoScroller).toBeDefined();
  });

  it('auto-scrolls on load', function() {
    loadFixtures('auto-scroller.html');

    expect(window.parent.postMessage).toHaveBeenCalledWith({ scrollToTop: true }, '*');
  });

  it('does not auto-scroll when it is disabled', function() {
    loadFixtures('auto-scroller-disabled.html');

    expect(window.parent.postMessage).not.toHaveBeenCalled();
  });
});
