module Employer
  class Location < OpenStruct
    def name_index
      name.to_s.sub(/^Tesco /i, '').first
    end

    def address
      [
        address_line_one,
        address_line_two,
        address_line_three,
        town,
        county,
        postcode
      ].reject(&:blank?).join("\n")
    end

    def available?
      available
    end
  end
end
