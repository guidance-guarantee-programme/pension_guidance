require_relative 'page'

module Pages
  class Guide < Page
    set_url('/{slug}')
    set_url_matcher(%r{\/(\w|-)+$})

    element :primary_heading, 'h1'
    elements :option_links, '.t-option'
    elements :section_headings, 'article.text h2'

    elements :journey_nav_steps, '.t-journey-nav-step'
    elements :journey_subnav_steps, '.t-journey-subnav-step'

    element :aside_heading, '.t-aside--heading'
    elements :aside_links, '.t-aside--link'

    element :calculator, '.t-calculator'

    element :next_link, '.t-next-page'
    element :previous_link, '.t-previous-page'

    def aside_heading_url
      aside_heading['href']
    end

    def aside_section_urls
      aside_links.collect do |aside_link|
        aside_link['href']
      end
    end

    def primary_heading_url
      "##{primary_heading['id']}"
    end

    def section_urls
      section_headings.collect do |section_heading|
        "##{section_heading['id']}"
      end
    end
  end
end
