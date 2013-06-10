require 'rubygems'
require 'rmagick'
require 'pp'
include Magick


@image=Image.read("/Users/elanakoren/Documents/setcards/master.png").first
#face=image.crop!(270,55,194,194)
#face.write("/Users/elanakoren/Documents/setcards/crop.png")


def vertical
  save_me = Array.new
  silverflag = false
  @image.each_pixel do |pixel, col, row|
    if pixel.to_color == 'silver'
      silverflag = true
    elsif pixel.to_color == 'white' and silverflag
      save_me.push([col, row])
      silverflag = false
    end
    File.open("outputfile2", "r+") do |output|
      save_me.each do |sublist|
        output << sublist
        output << "\n"
      end
    end
  end
end

def horizontal
  silvercount = 0
  @image.each_pixel do |pixel, col, row|
    if pixel.to_color == 'silver'
      silvercount = silvercount + 1
    end
    if pixel.to_color != 'silver'
      silvercount = 0
    end
    if silvercount >= 940
      puts [col, row].to_s
      silvercount = 0
    end
  end
end

if __FILE__ == $0
  #horizontal
  vertical
end
