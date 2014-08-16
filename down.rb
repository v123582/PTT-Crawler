require 'nokogiri'
require 'open-uri'
require 'time'

`mkdir index`
`mkdir down`
`wget --post-data="yes=yes" --save-cookies=cookie.txt --keep-session-cookies --no-check-certificat https://www.ptt.cc/ask/over18`
`wget -P index --load-cookies=cookie.txt https://www.ptt.cc/bbs/Gossiping/index.html --no-check-certificat`

html = open("index/index.html").read
dom_tree = Nokogiri::HTML(html)
start_page = dom_tree.css('#main-container #action-bar-container .action-bar a')[3].attr('href')
start_page = start_page.split(".html")
start_page = start_page[0].split("index")
start_page = start_page[1]
start_page = start_page.to_i + 1
#356
count =0
for i in start_page.downto(0) do
`wget -P index --load-cookies=cookie.txt https://www.ptt.cc/bbs/Gossiping/index#{i}.html --no-check-certifica`
puts "#{i}"
html = open("index/index#{i}.html").read
dom_tree = Nokogiri::HTML(html)
content_doms = dom_tree.css('#main-container .r-list-container .r-ent .title a')
	
   	for j in (content_doms.size-1).downto(0)

		x=content_doms[j].attr('href')
		`wget -O down/#{count}.htm --load-cookies=cookie.txt -c https://www.ptt.cc#{x} --no-check-certifica`
		puts "----->#{j}"
	    html = open("down/#{count}.htm").read
		dom_tree = Nokogiri::HTML(html)
		img_doms = dom_tree.css('#main-container').text
		header = dom_tree.css('#main-container #main-content .article-metaline').text
		border = dom_tree.css('#main-container #main-content .article-metaline-right').text
		reply = dom_tree.css('#main-container #main-content .push').text

		header = header.split("時間")
		time = header[1];
	    time = Time.parse(time).strftime("%Y%m%d%H%M%S").to_s
	    dict = time.to_s[0..3]+time.to_s[4..5]
	    now = Time.new.to_s[0..3]+Time.new.to_s[5..6]
	    puts "----->#{time.to_i}"
		if time.to_i <= 20140816183000 or File.exist?("page/#{time}.htm")
			puts "ending"
			break
		end
		`wget -O page/#{time}.htm --load-cookies=cookie.txt -c https://www.ptt.cc#{x} --no-check-certifica`
		sleep(0.1)
		count = count +1
	    
	end
	if time.to_i <= 20140816183000 or File.exist?("page/#{time}.htm")
		puts "ending"
	break
	end
end
`rm -rf index`
`rm -rf down`
`rm cookie.txt`
`rm over18`