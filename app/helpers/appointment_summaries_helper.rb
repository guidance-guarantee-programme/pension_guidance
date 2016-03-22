module AppointmentSummariesHelper
  def headers(level = 1)
    Nokogiri::HTML(@content).css("h#{level}").each_with_object({}) do |header, headers|
      headers[header[:id]] = header.text
    end
  end
end
