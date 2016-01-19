//= require jasmine-jquery

jasmine.getFixtures().fixturesPath = '../../spec/javascripts/fixtures';

describe('mobile nav toggler', function() {
  'use strict';

  /**
   * As .click() is non-standard, we need to stub in here
   * for PhantomJS. The jQuery $().click() handles the event
   * differently which is not sufficient for the tests here.
   *
   * @param  {Element} el
   * @return {null}
   */
  function click(el){
      var ev = document.createEvent('MouseEvent');
      ev.initMouseEvent(
          'click',
          true /* bubble */, true /* cancelable */,
          window, null,
          0, 0, 0, 0, /* coordinates */
          false, false, false, false, /* modifier keys */
          0 /*left*/, null
      );
      el.dispatchEvent(ev);
  }

  it('should be defined', function() {
    expect(PWPG.mobileNavToggler).toBeDefined();
  });

  describe('toggles visibility of the navigation', function() {
    beforeEach(function() {
      loadFixtures('mobile-nav-toggler.html');
      PWPG.mobileNavToggler.init();
    });

    it('adds `active` class on first click', function() {
      click($('.js-nav-toggler')[0]);
      expect($('.js-nav')).toHaveClass('active');
    });

    it('removes `active` class on second click', function() {
      click($('.js-nav-toggler')[0]);
      click($('.js-nav-toggler')[0]);
      expect($('.js-nav')).not.toHaveClass('active');
    });

    it('prevents the trigger link from being followed', function() {
      click($('.js-nav-toggler')[0]);
      expect(window.location.href.indexOf('#mobilenav')).toBe(-1);
    });
  });
});
