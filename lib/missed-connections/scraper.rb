require 'httparty'
require 'nokogiri'
require 'pry'

class MissedConnections::Scraper

  BASE_URL = 'https://newyork.craigslist.org'

  def self.scrape_title_page
    html = HTTParty.get("#{BASE_URL}/search/mis")
    doc = Nokogiri::HTML(html)

    doc.css('.content').css('.rows').css('.result-title').css('.hdrlnk').map do |title|
      url_ending = title.attributes["href"].value
      post_link = "#{BASE_URL}/#{url_ending}"

      {
        title: title.text,
        url: post_link
      }

    end
  end

  def self.scrape_post_page(post_link)
    html = HTTParty.get(post_link)
    doc = Nokogiri::HTML(html)
    {content: doc.css('#postingbody').text}
  end
end
