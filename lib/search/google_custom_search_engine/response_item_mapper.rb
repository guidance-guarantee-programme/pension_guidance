module Search
  class GoogleCustomSearchEngine
    class ResponseItemMapper
      attr_accessor :data
      private :data=

      def initialize(data)
        self.data = data
      end

      def id
        link.split('/').last
      end

      def title
        data['htmlTitle']
      end

      def link
        data['link']
      end

      def snippet
        data['htmlSnippet']
      end

      def mapped_item_response
        { id: id, title: title, link: link, snippet: snippet }
      end
    end
  end
end
