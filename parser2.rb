require 'rubygems'
require 'rmagick'
require 'pp'
include Magick


@image=Image.read("/Users/elanakoren/Documents/setcards/master.png").first
#face=image.crop!(270,55,194,194)
#face.write("/Users/elanakoren/Documents/setcards/crop.png")

COLS = 941
ROWS = 640

def parse_image(image)
  array = image.get_pixels(0,0,COLS,ROWS)
  two = []
  ROWS.times do |offset|
    row = array[offset * COLS, COLS].map{ |pixel| pixel.to_color == "silver" ? 0 : 1 }
    two[offset] = row
  end
  
  return two
end

def print_array(a)
  a.each do |r|
    puts r.join
  end
end

def is_upper_left_corner?(a, x, y)
  return (a[y][x] == 1 and a[y-1][x] == 0 and a[y][x-1] == 0 and a[y-1][x-1] == 0)
end

@two = parse_image(@image)
#print_array(@two)

@corners = []

(COLS).times do |x|
  (ROWS).times do |y|
   @corners.push [x,y] if is_upper_left_corner?(@two, x, y)
  end
end

def crop
  @corners.each_with_index do |corner, i|
    card=@image.crop(corner[0],corner[1], 95, 63)
    card.write("/Users/elanakoren/Documents/setcards/cards/" + i.to_s + ".png")
  end
end

crop