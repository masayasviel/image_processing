file_pass = "./images/Lenna.bmp"

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

monokuro = File.open("./outputImages/monokuro.bmp", "wb")

monokuro.print format_type
monokuro.print [file_size].pack("i*")
monokuro.print [0].pack("i*")
monokuro.print [header_size].pack("i*")
monokuro.print [40].pack("i*")
monokuro.print [width].pack("i*")
monokuro.print [height].pack("i*")
monokuro.print [1, color_bit].pack("s*")
monokuro.print [0, 0, 0, 0, 0, 0].pack("i*")

header_size.step(height*width*3+header_size-1, 3) do |i|
    3.times do
        monokuro.print [[
            data[i],
            data[i + 1],
            data[i + 2],
        ].map{|x| x.unpack("C*")[0]}.sum / 3].pack("C*")
    end
end

# (height*3-1).times do |i|
#     width.times do |j|
#         monokuro.print [[
#             data[i * width + j + header_size],
#             data[i * width + j + header_size + 1],
#             data[i * width + j + header_size + 2],
#         ].map{|x| x.unpack("C*")[0]}.sum / 3].pack("C*")
#     end
# end

monokuro.close