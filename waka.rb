#!/usr/bin/env ruby
require "httparty"
require "pry"

require 'markdown-tables'

module Waka
  def self.get_duration_hrs_and_mins(duration)
    hours = (duration / (60 * 60)).truncate(0)
    minutes = (duration / ( 60 ) % 60).truncate(0)
    "#{hours}h #{minutes}m"
  rescue
    ""
  end

  def self.getDevHours(start=1, endDate=0, dataBucket=[])
    # base case if we reached the end of the week
    if (start ==  7 and endDate == 6)
      
      labels = ["Day", "Hours of coding", "Languages/Tech"]
      dataBucket = dataBucket.reverse()

     return  MarkdownTables.make_table(labels, dataBucket, is_rows: true)
    end

    start_range = (DateTime.now - start).strftime("%Y-%m-%d")
    end_range = (DateTime.now - endDate).strftime("%Y-%m-%d")

    response = HTTParty.get("https://wakatime.com/api/v1/users/current/summaries?start=#{start_range}&end=#{end_range}",{
      headers: {"authorization" => "Basic #{ENV["WAKA_KEY"]}" }
    })


     
    codingSeconds = 0
    languages = []

    response["data"].each do |data|

      codingSeconds += data["grand_total"]["total_seconds"]
      data["languages"].each_with_index  do |lang, idx|
       languages << lang["name"]
      end
    end

    hoursOfCode = get_duration_hrs_and_mins(codingSeconds)
    dataBucket << [end_range, hoursOfCode, languages.uniq.join(' ')]
    
    return getDevHours(start+1, endDate+1, dataBucket)
    
  rescue JSON::ParserError
    return "*WAKA API call failed, oh no!*"
  end
end
