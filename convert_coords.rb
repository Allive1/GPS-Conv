require 'rubygems'
require 'watir-webdriver'

browser = Watir::Browser.new :firefox
browser.goto "http://rechneronline.de/geo-coordinates/"
distance = []
lat = []
lon = []
a = []
i = 0
x = 0
y = 0
fileObj = File.open("coordinates.txt") do |f|
  #while (line = fileObj.gets)
  f.lines.each do |line|
    #puts(line.split)

      a.push(line.split('\n'))


  end
end
temp = []



while(i < a.length)
  t = a[i]

  if(i%2 == 0)
    temp = a.at(i).to_s.split('\t')
      lon.push(-1 * temp[0].to_s.gsub(/[^\d^\.]/, '').to_f)
      x= x + 1

  else(i%2 != 1)
    temp = a.at(i).to_s.split('\t')
      lat.push(temp[1].to_s.gsub(/[^\d^\.]/, '').to_f)
      y = y + 1
  end

  i = i + 1

end

puts lon
#puts lon
#fileObj.close



i = 1
while(i < 2)
  browser.text_field(:id => 'xx').set(lat[i-1] + ' ' + lon[i-1])
  browser.text_field(:id => 'yy').set(lat[i] + ' ' + lon[i])
  browser.button(:value => 'Calculate').click
  browser.wait(5)
  distance.push(browser.text_field(:id => 'res').text)

end

