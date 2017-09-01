module Tesco
  class Location < OpenStruct
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
  end
end
