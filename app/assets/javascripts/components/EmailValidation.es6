(function() {
  'use strict';

  class EmailValidation extends PWPG.BaseComponent {
    constructor($component) {
      super($component);

      this.$component.mailgun_validator({
        api_key: this.$component.data('api-key'),
        api_host: this.$component.data('api-host'),
        in_progress: this.showLoadingSpinner.bind(this),
        success: this.onSuccess.bind(this),
        error: this.onError.bind(this)
      });

      this.insertSuggestionContainer();
      this.insertLoadingSpinner();
    }

    onSuccess(data) {
      this.hideLoadingSpinner();

      if (!data.is_valid || data.did_you_mean) {
        this.showSuggestion(data.is_valid, data.did_you_mean);
      } else {
        this.clearSuggestion();
      }
    }

    onError(message) {
      this.hideLoadingSpinner();
      this.$suggestionContainer.html(message);
    }

    insertLoadingSpinner() {
      if (this.$loadingSpinner) {
        return;
      }

      this.$loadingSpinner = $('<div class="ajax-loader ajax-loader--24px hidden"></div>');
      this.$loadingSpinner.insertAfter(this.$component);
    }

    showLoadingSpinner() {
      this.clearSuggestion();
      this.$loadingSpinner.removeClass('hidden');
    }

    hideLoadingSpinner() {
      this.$loadingSpinner.addClass('hidden');
    }

    insertSuggestionContainer() {
      if (this.$suggestionContainer) {
        return;
      }

      this.$suggestionContainer = $('<div class="form-hint email-suggestion" aria-live="polite" />');
      this.$suggestionContainer.insertAfter(this.$component);
    }

    showSuggestion(isValid, didYouMean) {
      let messages = [],
          message;

      if (!isValid) {
        messages.push("that doesn't look like a valid address");
      }

      // Null (falsey) if no suggestion
      if (didYouMean) {
        messages.push(
          `did you mean
          <button class="button-link t-suggestion js-populate-suggested-email">${didYouMean}</button>?
        `);
      }

      message = messages.join(', ');
      message = message.charAt(0).toUpperCase() + message.slice(1);

      // Insert the message
      this.$suggestionContainer.html(message);

      // And now add the click behaviour to populate the suggestion
      $('.js-populate-suggested-email').click((event) => {
        event.preventDefault();

        // Populate the suggestion and then remove the message
        this.$component.val(event.target.innerHTML);
        this.clearSuggestion();
      });
    }

    clearSuggestion() {
      this.$suggestionContainer.empty();
    }
  }

  window.PWPG = window.PWPG || {};
  window.PWPG.EmailValidation = EmailValidation;
})();
