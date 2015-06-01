//= require jasmine-jquery

jasmine.getFixtures().fixturesPath = '../../spec/javascripts/fixtures';

function setUpFixtureTest(fixtureFile) {
  'use strict';
  loadFixtures(fixtureFile);
  window.ga = window.ga || function() {};
  PWPG.clickTracker.init();
  spyOn(PWPG.clickTracker, 'sendEvent');
}

describe('click tracker', function() {
  'use strict';

  it ('should be defined', function() {
    expect(PWPG.clickTracker).toBeDefined();
  });

  it ('sends data to google analytics', function() {
    window.ga = window.ga || function() {};
    spyOn(window, 'ga');

    PWPG.clickTracker.sendEvent('exampleActionLabel');

    expect(window.ga).toHaveBeenCalled();
  });

  it ('creates a category name based on the pathname of the page', function() {
    PWPG.clickTracker.pathname = '/';
    expect(PWPG.clickTracker.categoryName()).toEqual('homepage');

    PWPG.clickTracker.pathname = '/tax';
    expect(PWPG.clickTracker.categoryName()).toEqual('tax');

    PWPG.clickTracker.pathname = '/pension-pot-options';
    expect(PWPG.clickTracker.categoryName()).toEqual('pension-pot-options');
  });

  describe('tracks links in global components', function() {

    beforeEach(function() {
      setUpFixtureTest('gov-uk-template.html');
    });

    it('adds click tracking to links in the header', function() {
      $('#global-header a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('global header', '/url');
    });

    it('adds click tracking to links in the masthead', function() {
      $('.l-masthead a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('masthead', '/url');
    });

    it('adds click tracking to links in the footer', function() {
      $('#footer a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('footer', '/url');
    });
  });

  describe('tracks links on the homepage', function() {

    beforeEach(function() {
      setUpFixtureTest('homepage.html');
    });

    it('adds click tracking to links the quick links', function() {
      $('.quick-links a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('quick links', '/url');
    });

    it('adds click tracking to links in the introduction', function() {
      $('.l-home-top-slot .l-column-third a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('introduction', '/url');
    });

    it('adds click tracking to links in the appointments promo', function() {
      $('.l-home-top-slot-promo a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('appointments', '/url');
    });

    it('adds click tracking to links in the journey promo', function() {
      $('.journey-promo a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('journey promo', '/url');
    });

    it('adds click tracking to links in the guides directory', function() {
      $('.l-home-guides a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('guides directory', '/url');
    });

    it('adds click tracking to links in the about the service promo', function() {
      $('.l-home-about a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('about the service', '/url');
    });
  });

  describe('tracks links on guide pages', function() {

    beforeEach(function() {
      setUpFixtureTest('guide.html');
    });

    it('adds click tracking to links in the breadcrumb', function() {
      $('.breadcrumbs a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('breadcrumb', '/url');
    });

    it('adds click tracking to links in the content', function() {
      $('article a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('content', '/url');
    });

    it('adds click tracking to links in the options table', function() {
      $('.ga-options-table a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('options table', '/url');
    });

    it('adds click tracking to links in the pager', function() {
      $('.pager a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('pager', '/url');
    });

    it('adds click tracking to links in the journey sidebar', function() {
      $('.ga-journey-sidebar a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('journey sidebar', '/url');
    });

    it('adds click tracking to links in the elsewhere sidebar', function() {
      $('.ga-elsewhere-sidebar a').trigger('click');
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('elsewhere sidebar', '/url');
    });
  });
});
