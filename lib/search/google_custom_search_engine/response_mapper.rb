module Search
  class GoogleCustomSearchEngine
    class ResponseMapper
      attr_accessor :body
      private :body=

      def initialize(response)
        self.body = response.body
      end

      def mapped_response
        { total_results: total_results, items: items }
      end

      private

      def items
        body.fetch('items', []).map do |item_hash|
          ResponseItemMapper.new(item_hash).mapped_item_response
        end
      end

      def paging_metadata
        body['queries']['request'].first
      end

      def total_results
        paging_metadata['totalResults'].to_i
      end

      def offset
        paging_metadata['startIndex'].to_i - 1
      end
    end
  end
end
