Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components',
                                                         'govuk_elements', 'public', 'sass')

Rails.application.config.assets.paths.unshift Rails.root.join('vendor', 'assets', 'bower_components',
                                                              'govuk_elements', 'govuk', 'public', 'images')

Rails.application.config.assets.precompile += %w( icons/icon-pointer.png
                                                  icons/icon-pointer-2x.png
                                                  pensions-guidance.css
                                                  pensions-guidance-ie6.css
                                                  pensions-guidance-ie7.css
                                                  pensions-guidance-ie8.css
                                                  styleguide.css  )
