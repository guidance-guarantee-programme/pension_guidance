//= require jasmine-jquery

jasmine.getFixtures().fixturesPath = '../../spec/javascripts/fixtures';

describe('click tracker', function() {
  'use strict';

  var clickEventLogger, setUpFixtureTest;

  clickEventLogger = new PWPG.ClickEventLogger();
  beforeEach(function() {
    spyOn(clickEventLogger, 'sendEvent');
  });

  setUpFixtureTest = function setUpFixtureTest(fixtureFile) {
    loadFixtures(fixtureFile);
    PWPG.clickTracker.init(clickEventLogger);
  };

  describe('tracks links in global components', function() {

    beforeEach(function() {
      setUpFixtureTest('gov-uk-template.html');
    });

    it('adds click tracking to links in the header', function() {
      $('#global-header a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('global header', '/url');
    });

    it('adds click tracking to links in the masthead', function() {
      $('.l-masthead a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('masthead', '/url');
    });

    it('adds click tracking to links in the footer', function() {
      $('#footer a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('footer', '/url');
    });
  });

  describe('tracks links on the homepage', function() {

    beforeEach(function() {
      setUpFixtureTest('homepage.html');
    });

    it('adds click tracking to links the quick links', function() {
      $('.quick-links a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('quick links', '/url');
    });

    it('adds click tracking to links in the introduction', function() {
      $('.l-home-top-slot .l-column-third a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('introduction', '/url');
    });

    it('adds click tracking to links in the appointments promo', function() {
      $('.l-home-top-slot-promo a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('appointments', '/url');
    });

    it('adds click tracking to links in the journey promo', function() {
      $('.journey-promo a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('journey promo', '/url');
    });

    it('adds click tracking to links in the guides directory', function() {
      $('.l-home-guides a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('guides directory', '/url');
    });

    it('adds click tracking to links in the about the service promo', function() {
      $('.l-home-about a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('about the service', '/url');
    });
  });

  describe('tracks links on guide pages', function() {

    beforeEach(function() {
      setUpFixtureTest('guide.html');
    });

    it('adds click tracking to links in the breadcrumb', function() {
      $('.breadcrumbs a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('breadcrumb', '/url');
    });

    it('adds click tracking to links in the content', function() {
      $('article a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('content', '/url');
    });

    it('adds click tracking to links in the options table', function() {
      $('.ga-options-table a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('options table', '/url');
    });

    it('adds click tracking to links in the pager', function() {
      $('.pager a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('pager', '/url');
    });

    it('adds click tracking to links in the journey sidebar', function() {
      $('.ga-journey-sidebar a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('journey sidebar', '/url');
    });

    it('adds click tracking to links in the elsewhere sidebar', function() {
      $('.ga-elsewhere-sidebar a').trigger('click');
      expect(clickEventLogger.sendEvent).toHaveBeenCalledWith('elsewhere sidebar', '/url');
    });
  });
});
