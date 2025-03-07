(function() {
  'use strict';

  class CharacterLimit extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      this.$input = this.$component.find('.js-character-limit-input');
      // ie9 doesn't recognise the maxlength attribute
      this.characterLimit = this.$input.attr('data-maxlength');
      this.countdownText = this.$input.attr('data-countdown-text') || '(total) characters remaining of (limit) characters';

      if (!this.characterLimit) {
        return;
      }

      this.insertCountdown();
      this.bindEvents();
    }

    insertCountdown() {
      const countdownId = `${this.$input.attr('id')}_characters_remaining`;

      this.$remainingTextEl = $('<p />')
        .attr('id', countdownId)
        .html(this.getCountDownText());

      this.$input.attr('aria-describedby', countdownId);

      this.$remainingTextEl.insertAfter(this.$input);
    }

    getCountDownText() {

      return `<span class="js-live-region">
        ${this.countdownText.replace('(total)', this.getCharacterLeftCount()).replace('(limit)', this.characterLimit)}
      </span>`;
    }

    bindEvents() {
      this.$input.on('input propertychange keyup change', this.updateCount.bind(this));
    }

    updateCount() {
      this.$remainingTextEl.html(this.getCountDownText());

      const $liveRegion = this.$component.find('.js-live-region'),
      percentageCharactersLeft = (this.getCharacterLeftCount() / this.characterLimit);

      if (percentageCharactersLeft < 0) {
        this.$input.val(this.$input.val().substr(0, this.characterLimit));
        this.updateCount();
      }

      $liveRegion.removeAttr('aria-live aria-atomic');

      if (percentageCharactersLeft <= 0.5) {
        $liveRegion.attr('aria-live', 'polite');
        $liveRegion.attr('aria-atomic', true);
      }

      if (percentageCharactersLeft <= 0.4) {
        $liveRegion.attr('aria-atomic', false);
      }

      if (percentageCharactersLeft <= 0.2) {
        $liveRegion.attr('aria-live', 'assertive');
        $liveRegion.attr('aria-atomic', true);
      }
    }

    getCharacterLeftCount() {
      return this.characterLimit - this.$input.val().length;
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.CharacterLimit = CharacterLimit;
})();
