file_pass = "./images/napoleon.png"

File.open(file_pass, "rb") do |f|
    p f.gets.chomp
    p f.gets.chomp
end