//= require jasmine-jquery

// Fixture path when running tests in browser
//jasmine.getFixtures().fixturesPath = '/assets/fixtures/';

// Fixture path when running tests with rake
jasmine.getFixtures().fixturesPath="../../spec/javascripts/fixtures"

describe("click tracker", function() {

  it ('should be defined', function () {
    expect(PWPG.clickTracker).toBeDefined();
  });

  it ('sends data to google analytics', function () {
    window.ga = window.ga || function() {};
    spyOn(window, "ga");

    PWPG.clickTracker.sendEvent('exampleActionLabel')

    expect(window.ga).toHaveBeenCalled();
  });

  it ('creates a category name based on the pathname of the page', function () {
    PWPG.clickTracker.pathname = '/'
    expect(PWPG.clickTracker.categoryName()).toEqual('homepage');

    PWPG.clickTracker.pathname = '/tax'
    expect(PWPG.clickTracker.categoryName()).toEqual('tax');

    PWPG.clickTracker.pathname = '/pension-pot-options'
    expect(PWPG.clickTracker.categoryName()).toEqual('pension-pot-options');
  });

  describe("tracks links in global components", function() {

    beforeEach(function() {
      loadFixtures('gov-uk-template.html');
      window.ga = window.ga || function() {};
      PWPG.clickTracker.init();
      spyOn(PWPG.clickTracker, "sendEvent");
    });

    it("adds click tracking to links in the header", function() {
      $('#global-header a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('global header');
    });

    it("adds click tracking to links in the masthead", function() {
      $('.l-masthead a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('masthead');
    });

    it("adds click tracking to links in the footer", function() {
      $('#footer a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('footer');
    });
  });

  describe("tracks links on the homepage", function() {

    beforeEach(function() {
      loadFixtures('homepage.html');
      window.ga = window.ga || function() {};
      PWPG.clickTracker.init();
      spyOn(PWPG.clickTracker, "sendEvent");
    });

    it("adds click tracking to links the quick links", function() {
      $('.quick-links a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('quick links');
    });

    it("adds click tracking to links in the introduction", function() {
      $('.l-home-top-slot .l-column-third a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('introduction');
    });

    it("adds click tracking to links in the appointments promo", function() {
      $('.l-home-top-slot-promo a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('appointments');
    });

    it("adds click tracking to links in the journey promo", function() {
      $('.journey-promo a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('journey promo');
    });

    it("adds click tracking to links in the guides directory", function() {
      $('.l-home-guides a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('guides directory');
    });

    it("adds click tracking to links in the about the service promo", function() {
      $('.l-home-about a').trigger( "click" );
      expect(PWPG.clickTracker.sendEvent).toHaveBeenCalledWith('about the service');
    });
  });
});

