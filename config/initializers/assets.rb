Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components',
                                                         'govuk_elements', 'public', 'sass')

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components',
                                                         'govuk_elements', 'public', 'images')

Rails.application.config.assets.paths.unshift Rails.root.join('vendor', 'assets', 'bower_components',
                                                              'govuk_elements', 'govuk', 'public', 'images')

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components',
                                                         'moj.slot-picker', 'dist', 'javascripts')

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components',
                                                         'moj.slot-picker', 'dist', 'stylesheets')

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components',
                                                         'moj.slot-picker', 'vendor')

Rails.application.config.assets.precompile += %w( *.png
                                                  apple-touch-icon-120x120.png
                                                  apple-touch-icon-152x152.png
                                                  apple-touch-icon-60x60.png
                                                  apple-touch-icon-76x76.png
                                                  favicon.ico
                                                  gov.uk_logotype_crown.png
                                                  icon-arrow-left.png
                                                  icons/icon-pointer-2x.png
                                                  icons/icon-pointer.png
                                                  opengraph-image.png
                                                  pensions-guidance-ie6.css
                                                  pensions-guidance-ie7.css
                                                  pensions-guidance-ie8.css
                                                  pensions-guidance-print.css
                                                  pensions-guidance.css
                                                  styleguide.css
                                                  bootstrap/js/affix.js
                                                  bootstrap/js/scrollspy.js
                                                  handlebars/handlebars.js
                                                  moj.slot-picker/vendor/modernizr.custom.85598.js
                                                  moj.slot-picker/dist/stylesheets/moj.slot-picker.css
                                                  moj.slot-picker/dist/javascripts/moj.slot-picker.js
                                                  moj.slot-picker/dist/stylesheets/moj.date-slider.css
                                                  moj.slot-picker/dist/javascripts/moj.date-slider.js )
