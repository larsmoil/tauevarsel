require "nokogiri"
require "open-uri"

task :refresh_streets => :environment do

  logger = Rails.logger

  urls = ["http://www.bymiljoetaten.oslo.kommune.no/miljo_og_renhold/renhold/varrengjoring/sentrum/",
          "http://www.bymiljoetaten.oslo.kommune.no/miljo_og_renhold/renhold/varrengjoring/ost/",
          "http://www.bymiljoetaten.oslo.kommune.no/miljo_og_renhold/renhold/varrengjoring/vest/",
          "http://www.bymiljoetaten.oslo.kommune.no/miljo_og_renhold/renhold/varrengjoring/nord/"]

  logger.info "Deleted #{StreetEvent.delete_all} rows."

  urls.each do |url|
    # Get a Nokogiri::HTML:Document for the page we’re interested in...
    logger.info "Processing #{url}"
    doc = Nokogiri::HTML(open(url))

    ####
    # Search for nodes by xpath
    doc.xpath('//table[@class = "sortable"]/tbody/tr').drop(1).each do |tr|
      non_empty = tr.children.find_all { |c| ! c.content.strip.empty? }
      street, stretch, date, time_of_day = non_empty.map(&:content).map(&:strip)
      unless date.nil?
        begin
          date = "#{Time.now.year}-#{date.split.first[0..1]}-#{date.split.first[2..3]}"
          date = Date.strptime(date, "%Y-%m-%d")
          e = StreetEvent.new(street: street, stretch: stretch, date: date, time_of_day: time_of_day)
          unless e.save
            logger.warn "Got errors: #{e.errors.messages} while saving #{e}"
          end
        rescue ArgumentError
          logger.debug "Could not parse date: #{date}, not creating an event for street #{street}"
        end
        # $stderr.puts "Street: #{street}, stretch: #{stretch}, date: #{date}, time_of_day: #{time_of_day}"
      end
    end
  end

  logger.info "StreetEvent.count = #{StreetEvent.count}"
end
