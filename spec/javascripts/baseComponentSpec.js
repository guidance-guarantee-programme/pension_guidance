//= require jasmine-jquery

jasmine.getFixtures().fixturesPath = '../../spec/javascripts/fixtures';

describe('BaseComponent', function() {
  'use strict';

  it('should be defined', function() {
    expect(PWPG.BaseComponent).toBeDefined();
  });

  describe('creates a common interface for components', function() {
    it('sets the $component instance variable', function() {
      var $component = 'test';
      var baseComponent = new PWPG.BaseComponent($component);

      expect(baseComponent.$component).toBe($component);
    });

    it('provides a feature test for input types', function() {
      var baseComponent = new PWPG.BaseComponent('test');

      expect(baseComponent.checkInputSupported).toBeDefined();
      expect(baseComponent.checkInputSupported('text')).toBe(true);
      expect(baseComponent.checkInputSupported('flamboyant')).toBe(false);
    });
  });

});
