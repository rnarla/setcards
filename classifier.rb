# This script creates a JSON object which fully specifies the properties of each card.
# It exploits patterns already present in the data.

require 'rubygems'
require 'pp'
require 'json'

@hashlist = Hash.new

def shape_classifier
  Dir.foreach('/Users/elanakoren/Documents/setcards/cards') do |card|
    if card.split('.')[1] == 'png' # there are a few hidden files that aren't card images, ignore them
      card_num = Integer(card.split('.')[0])
      if card_num < 27
        @hashlist.merge!({card_num => {:shape => :diamond}})
      elsif card_num > 26 and card_num < 54
        @hashlist.merge!({card_num => {:shape => :oblong}})
      else 
        @hashlist.merge!({card_num => {:shape => :sigmoid}})
      end 
    end
  end
end

def filling_classifier()
  @hashlist.each_pair do |num, properties|
    if num % 3 == 0
      properties.merge!({:filling => :empty})
    elsif num % 3 == 1
      properties.merge!({:filling => :hatched})
    else
      properties.merge!({:filling => :solid})
    end
  end
end

def color_classifier()
  latest_red_card = 0
  latest_green_card = 3
  latest_purple_card = 6
  9.times do
    set_three(:red, latest_red_card)
    set_three(:green, latest_green_card)
    set_three(:purple, latest_purple_card)
    latest_red_card += 9
    latest_green_card += 9
    latest_purple_card += 9
  end
end
  
def set_three(color_symbol, num)
  (num..num+2).each do |index| 
    @hashlist[index].merge!({:color => color_symbol})
  end
end
    
def number_classifier()
  num = 0
  3.times do
    9.times do
      @hashlist[num].merge!({:number => 1})
      num += 1
    end
    9.times do
      @hashlist[num].merge!({:number => 2})
      num += 1
    end
    9.times do
      @hashlist[num].merge!({:number => 3})
      num += 1
    end  
  end
end

def print_hashlist()
  @hashlist.each do |hl|
    puts hl.to_json
  end
end

shape_classifier()
number_classifier()
filling_classifier()
color_classifier()

File.open("cards.json", "w") do |file|
  file.puts(@hashlist.to_json)
file.close      
end