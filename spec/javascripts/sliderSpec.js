//= require jasmine-jquery

jasmine.getFixtures().fixturesPath = '../../spec/javascripts/fixtures';

describe('Slider', function() {
  'use strict';

  it('should be defined', function() {
    expect(PWPG.Slider).toBeDefined();
  });

  describe('provides a range input when supported', function() {
    function instantiateSlider($component, isRangeSupported) {
      spyOn(PWPG.Slider.prototype, 'checkInputSupported').and.returnValue(isRangeSupported);
      var slider = new PWPG.Slider($component);
      return slider;
    }

    beforeEach(function() {
      loadFixtures('slider.html');
    });

    describe('responds to browser support of range input', function() {
      it('does not make a range input when unsupported', function() {
        var $component = $('[data-slider]');
        instantiateSlider($component, false);

        expect($('.slider__range-input').length).toBe(0);
      });

      it('makes a range input when supported', function() {
        var $component = $('[data-slider]');
        instantiateSlider($component, true);

        expect($('.slider__range-input').length).toBe(1);
      });
    });

    describe('keeps the two inputs in sync', function() {
      beforeEach(function() {
        var $component = $('[data-slider]');
        this.slider = instantiateSlider($component, true);
        this.$textInput = $('[data-slider-text-input]');
        this.$rangeInput = $('[data-slider-range-input]');
      });

      it('updates the range if the text input changes', function() {
        this.$textInput.val('25').trigger('change');
        expect(this.$rangeInput.val()).toBe('25');
      });

      it('updates the text if the range input changes', function() {
        this.$rangeInput.val('5').trigger('change');
        expect(this.$textInput.val()).toBe('5');
      });

      it('calls `refreshSlider` when the text input changes', function() {
        spyOn(PWPG.Slider.prototype, 'refreshSlider');
        this.$textInput.val('25').trigger('change');

        expect(this.slider.refreshSlider).toHaveBeenCalled();
      });

      it('calls `refreshSlider` when the range input changes', function() {
        spyOn(PWPG.Slider.prototype, 'refreshSlider');
        this.$rangeInput.val('25').trigger('change');

        expect(this.slider.refreshSlider).toHaveBeenCalled();
      });
    });

    describe('uses the attributes from the component', function() {
      beforeEach(function() {
        var $component = $('[data-slider]');
        this.slider = instantiateSlider($component, true);
        this.$textInput = $('[data-slider-text-input]');
        this.$rangeInput = $('[data-slider-range-input]');
      });

      it('gives the relevant attributes to the range input', function() {
        expect(this.$rangeInput.attr('min')).toBe('0');
        expect(this.$rangeInput.attr('max')).toBe('30');
        expect(this.$rangeInput.attr('value')).toBe('20');
        expect(this.$rangeInput.attr('step')).toBe('1');
      });

      it('ensures the name attribute only belongs to the text input', function() {
        expect(this.$textInput.attr('name')).toBe('slider');
        expect(this.$rangeInput.attr('name')).toBeUndefined();

        expect(this.$textInput.attr('class')).toContain('t-slider-input');
        expect(this.$rangeInput.attr('class')).not.toContain('t-slider-input');
      });
    });
  });

  describe('handling multiple sliders on the same page', function() {
    beforeEach(function() {
      loadFixtures('slider-multiple.html');
    });

    it('only updates the relevant input', function() {
      var $component1 = $('#slider-1');
      var $component2 = $('#slider-2');
      var $textInput1;
      var $rangeInput1;
      var $textInput2;
      var $rangeInput2;

      new PWPG.Slider($component1);
      new PWPG.Slider($component2);

      $textInput1 = $component1.find('[data-slider-text-input]');
      $rangeInput1 = $component1.find('[data-slider-range-input]');

      $textInput2 = $component2.find('[data-slider-text-input]');
      $rangeInput2 = $component2.find('[data-slider-range-input]');

      $rangeInput1.val('15').trigger('change');

      expect($textInput1.val()).toBe('15');
      expect($textInput2.val()).toBe('10');

      expect($rangeInput1.val()).toBe('15');
      expect($rangeInput2.val()).toBe('10');
    });
  });
});
