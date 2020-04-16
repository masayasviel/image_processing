file_pass = "./images/Lenna.bmp"

f = File.open(file_pass, "rb")
data = f.read
f.close
format_type = data[0..1]
file_size = data[2..5]
header_size = data[10..13]
width = data[18..21]
height = data[22..25]
color_bit = data[28..29]

puts "format_type: " + format_type
puts "file_size: " + file_size.unpack("i*")[0].to_s + " [byte]"
puts "header_size: " + header_size.unpack("i*")[0].to_s + " [byte]"
puts "image_width: " + width.unpack("i*")[0].to_s + " [px]"
puts "image_height: " + height.unpack("i*")[0].to_s + " [px]"
puts "color: " + color_bit.unpack("s*")[0].to_s + " [bit]"