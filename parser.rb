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
      save_me.push([col])
      silverflag = false
    end
  end
end

def horizontal
  silvercount = 0
  save_me = Array.new
  @image.each_pixel do |pixel, col, row|
    if pixel.to_color == 'silver'
      silvercount = silvercount + 1
    end
    if pixel.to_color != 'silver'
      silvercount = 0
    end
    if silvercount >= 940
      save_me.push(row)
      silvercount = 0
    end
  end
  horiz_pairs(save_me)
end

def horiz_pairs(list)
  coord_pairs = Array.new
  list.each_with_index do |y_coord, i|
    if i == 0
      next
    else
      if y_coord - list[i-1] > 1
        coord_pairs.push([list[i-1], y_coord])
      end
    end
  end
  return coord_pairs
end
  
  

if __FILE__ == $0
  horizontal
  #vertical
end