require 'nokogiri'
require 'open-uri'


for i in 204..1693
puts "#{i}"
html = open("201407/#{i}.htm").read
dom_tree = Nokogiri::HTML(html)
img_doms = dom_tree.css('#main-container').text
header = dom_tree.css('#main-container #main-content .article-metaline').text
border = dom_tree.css('#main-container #main-content .article-metaline-right').text
reply = dom_tree.css('#main-container #main-content .push').text

header = header.split("時間")
time = header[1];

header = header[0].split("標題")
title = header[1];
header = dom_tree.css('#main-container #main-content .article-metaline').text
img_doms = dom_tree.css('#main-container').text
img_doms = img_doms.gsub('看板Gossiping', '') 
img_doms = img_doms.gsub('站內Gossiping', '') 
img_doms = img_doms.split("#{header}")
img_doms = img_doms[1].split('※ 發信站:')
img_doms = img_doms[0].delete("\n")
#`touch 201407/#{i}.txt`
#File.open("201407/#{i}.txt", 'w') { |file| file.write("@@@"+"時間,"+time+"\n") }
#File.open("201407/#{i}.txt", 'a') { |file| file.write("@@@"+"標題,"+title+"\n") }
#File.open("201407/#{i}.txt", 'a') { |file| file.write("@@@"+"內文,"+img_doms+"\n") }
#File.open("201407/#{i}.txt", 'a') { |file| file.write("@@@"+"推文,"+"\n"+reply+"\n") }
File.open("201407/20140805.txt", 'a') { |file| file.write("@@@"+img_doms+"\n") }
#`rm *.htm`
end

