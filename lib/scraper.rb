require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  def get_page
    # opens with open-uri and parses with Nokogiri's HTML
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses")) 
    # iterates through collection and instantiates objects with attrs
    # uses Nokogiri's #css to narrow in on specific HTML selector
    doc.css(".post").each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end
  
  def get_courses
    # operates on HTML doc using CSS selector
    # grabs all HTML elements that contain a course attribute
    # returns a collection of course offerings as Nokogiri XML elements
    self.get_page.css(".post")
  end
  
  def make_courses
    # instantiate a Course object with correctly scrapted attributes
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end


Scraper.new.get_page
