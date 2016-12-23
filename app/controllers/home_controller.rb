class HomeController < ApplicationController
  layout :resolve_layout

  def show
    expires_in Rails.application.config.cache_max_age, public: true
  end

  def book_an_appointment
  end

  def footer?
    false
  end

  private

  def resolve_layout
    case action_name
    when 'show'
      'home'
    when 'book_an_appointment'
      'landing'
    end
  end
end
