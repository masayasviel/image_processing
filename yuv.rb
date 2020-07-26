file_pass = "./images/Mandrill.bmp"

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

yuv = File.open("./outputImages/yuv.bmp", "wb")

yuv.print format_type
yuv.print [file_size].pack("i*")
yuv.print [0].pack("i*")
yuv.print [header_size].pack("i*")
yuv.print [40].pack("i*")
yuv.print [width].pack("i*")
yuv.print [height].pack("i*")
yuv.print [1, color_bit].pack("s*")
yuv.print [0, 0, 0, 0, 0, 0].pack("i*")

header_size.step(height*width*3+header_size-1, 3) do |i|
    b, g, r = [data[i], data[i + 1], data[i + 2]].map{|x| x.unpack("C*")[0]}
    yuv.print [(r + 2*g + b) / 4].pack("C*") # Y
    yuv.print [b - g].pack("C*") # Cb
    yuv.print [r - g].pack("C*") # Cr

end

yuv.close