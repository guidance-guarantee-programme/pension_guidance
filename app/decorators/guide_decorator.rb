class GuideDecorator < Draper::Decorator
  delegate :id, :slug, :description

  def url
    "/#{slug}"
  end

  def title
    @title ||= case content_type
               when :govspeak
                 content_document.headers.find { |header| header.level == 1 }.try(:text)
               else
                 content_document.css('h1').first.try(:text)
               end
  end

  def content
    @content ||= case content_type
                 when :govspeak
                   content_document.to_sanitized_html.html_safe
                 else
                   guide_content.html_safe
                 end
  end

  private

  def content_type
    object.content_type
  end

  def guide_content
    object.content
  end

  def content_document
    @content_document ||= case content_type
                          when :govspeak
                            Govspeak::Document.new(guide_content)
                          else
                            Nokogiri::HTML(guide_content)
                          end
  end
end
