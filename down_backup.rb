require 'nokogiri'
require 'open-uri'

#`wget --post-data="yes=yes" --save-cookies=cookie.txt --keep-session-cookies --no-check-certificat https://www.ptt.cc/ask/over18`
#`wget -P index --load-cookies=cookie.txt https://www.ptt.cc/bbs/Gossiping/index.html --no-check-certificat`

html = open("index/index.html").read
dom_tree = Nokogiri::HTML(html)
start_page = dom_tree.css('#main-container #action-bar-container .action-bar a')[3].attr('href')
start_page = start_page.split(".html")
start_page = start_page[0].split("index")
start_page = start_page[1]
start_page = start_page.to_i + 1
#356
for i in 2178..4261
#`wget -P index --load-cookies=cookie.txt https://www.ptt.cc/bbs/Gossiping/index#{i}.html --no-check-certifica`
puts "#{i}"
sleep(0.1)
end
count =0
for i in 2178..4261
puts "#{i}"
html = open("index/index#{i}.html").read
dom_tree = Nokogiri::HTML(html)
content_doms = dom_tree.css('#main-container .r-list-container .r-ent .title a')

   	for j in 0..(content_doms.size-1)
	x=content_doms[j].attr('href')
	`wget -O 201407/#{count}.htm --load-cookies=cookie.txt -c https://www.ptt.cc#{x} l --no-check-certifica`
	puts "#{j}"
sleep(0.1)
	count = count +1
	end
end
