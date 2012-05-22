require "nokogiri"
require "open-uri"

task :refresh_streets => :environment do

  # Get a Nokogiri::HTML:Document for the page we’re interested in...

  doc = Nokogiri::HTML(open('http://www.bymiljoetaten.oslo.kommune.no/miljo_og_renhold/renhold/varrengjoring/sentrum/'))

  ####
  # Search for nodes by xpath
  doc.xpath('//table/tbody/tr').drop(1).each do |tr|
    street, stretch, date, time_of_day = tr.children.find_all { |c| ! c.content.strip.empty? } .map { |c| c.content }
    unless date.nil?
      begin
        date = "#{Time.now.year}-#{date.split.first[0..1]}-#{date.split.first[2..3]}"
        date = Date.strptime(date, "%Y-%m-%d")
        StreetEvent.create!(street: street, stretch: stretch, date: date, time_of_day: time_of_day)
      rescue ArgumentError
        $stderr.puts "Could not parse date: #{date}"
      end
      puts "Street: #{street}, stretch: #{stretch}, date: #{date}, time_of_day: #{time_of_day}"
    end
  end
end
