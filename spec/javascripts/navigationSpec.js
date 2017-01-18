//= require jasmine-jquery

jasmine.getFixtures().fixturesPath = '../../spec/javascripts/fixtures';

describe('navigation', function() {
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
    expect(PWPG.Navigation).toBeDefined();
  });

  describe('toggles visibility of the navigation', function() {
    beforeEach(function() {
      loadFixtures('navigation.html');
      new PWPG.Navigation();
    });

    it('adds `active` class and correct aria attributes on first click', function() {
      click($('.js-nav-toggler')[0]);
      expect($('.js-nav')).toHaveClass('active');
      expect($('.js-nav')).toHaveAttr('aria-hidden', 'false');
      expect($('.js-nav-toggler')).toHaveAttr('aria-expanded', 'true');
    });

    it('removes `active` class and correct aria attributes on second click', function() {
      click($('.js-nav-toggler')[0]);
      click($('.js-nav-toggler')[0]);
      expect($('.js-nav')).not.toHaveClass('active');
      expect($('.js-nav')).toHaveAttr('aria-hidden', 'true');
      expect($('.js-nav-toggler')).toHaveAttr('aria-expanded', 'false');
    });
  });
});
