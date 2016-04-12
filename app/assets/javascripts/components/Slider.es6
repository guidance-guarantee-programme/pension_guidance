(function() {
  'use strict';

  class Slider extends PWPG.BaseComponent {
    constructor($component) {
      super($component);
      this.init();
    }

    init() {
      if (this.checkInputSupported('range')) {
        this.createSlider();
      }
    }

    createSlider() {
      this.$textInput = this.$component.find('[data-slider-text-input]');
      this.$rangeInput = this.$textInput
            .clone()
            .addClass('slider__range-input')
            .removeClass('t-slider-input')
            .removeAttr('data-slider-text-input name')
            .attr({
              'type': 'range',
              'aria-role': 'slider',
              'data-slider-range-input': ''
            })
            .appendTo(this.$component);

      this.syncInputs();
      this.decorateSlider();

      this.refreshSlider();
    }

    syncInputs() {
      this.$textInput.on('change keyup', () => {
        var val = this.$textInput.val();
        this.$rangeInput.val(val);
      });

      this.$rangeInput.on('change input', () => {
        this.$textInput.val(this.$rangeInput.val());
        this.$textInput.change();
      });
    }

    decorateSlider() {
      this.styleElement = document.createElement('style');
      document.body.appendChild(this.styleElement);

      this.$rangeInput.on('change input', () => { this.refreshSlider() });
      this.$textInput.on('change keyup', () => { this.refreshSlider() });
    }

    refreshSlider() {
      var selector = `#${this.$component.attr('id')} .slider__range-input`;

      var min = this.$rangeInput.attr('min');
      var max = this.$rangeInput.attr('max');
      var valueAsPercentage = ~~((this.$rangeInput.val() - min) / (max - min) * 100);

      var vendorTracks = ['-webkit-slider-runnable-', '-moz-range-'];

      var style = ``;

      vendorTracks.forEach((vendorTrack) => {
        style += `${selector}::${vendorTrack}track {
                   background-size: ${valueAsPercentage}% 100%;
                 }`;
      });

      this.styleElement.textContent = style;
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.Slider = Slider;

})();
