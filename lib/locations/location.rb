module Locations
  Location = Struct.new(:name, :address, :phone, :hours, :lat_lng) do
    def id
      name.downcase.gsub(/\W/, '-').gsub(/-{2,}/, '-')
    end
  end
end
