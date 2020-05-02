file_pass = "./monokuro.bmp"

f = File.open(file_pass, "rb")
data = f.read
f.close
format_type = data[0..1]
file_size = data[2..5].unpack("I*")[0]
header_size = data[10..13].unpack("I*")[0]
width = data[18..21].unpack("I*")[0]
height = data[22..25].unpack("I*")[0]
color_bit = data[28..29].unpack("C*")[0]

puts "format_type: " + format_type
puts "file_size: " + file_size.to_s + " [byte]"
puts "header_size: " + header_size.to_s + " [byte]"
puts "image_width: " + width.to_s + " [px]"
puts "image_height: " + height.to_s + " [px]"
puts "color: " + color_bit.to_s + " [bit]"