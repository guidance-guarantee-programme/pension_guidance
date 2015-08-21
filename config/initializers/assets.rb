Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components',
                                                         'govuk_elements', 'public', 'sass')

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components',
                                                         'govuk_elements', 'govuk', 'public',
                                                         'javascripts', 'vendor')

Rails.application.config.assets.paths.unshift Rails.root.join('vendor', 'assets', 'bower_components',
                                                              'govuk_elements', 'govuk', 'public', 'images')

Rails.application.config.assets.precompile += %w( apple-touch-icon-120x120.png
                                                  apple-touch-icon-152x152.png
                                                  apple-touch-icon-60x60.png
                                                  apple-touch-icon-76x76.png
                                                  favicon.ico
                                                  gov.uk_logotype_crown.png
                                                  icons/icon-pointer-2x.png
                                                  icons/icon-pointer.png
                                                  opengraph-image.png
                                                  pensions-guidance-ie6.css
                                                  pensions-guidance-ie7.css
                                                  pensions-guidance-ie8.css
                                                  pensions-guidance.css
                                                  styleguide.css )
