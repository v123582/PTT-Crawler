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
exist_flag = 0
flag = false
last_author = ''
#start_page = 4991
for i in start_page.downto(0) do
`wget -P index --load-cookies=cookie.txt https://www.ptt.cc/bbs/Gossiping/index#{i}.html --no-check-certifica`
#puts "#{i}"
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

		if dom_tree.css('#main-container #main-content .article-metaline .article-meta-tag').text != "作者標題時間"
			count = count +1
			next
		end	

		author = dom_tree.css('#main-container #main-content .article-metaline .article-meta-value')[0].text
		title = dom_tree.css('#main-container #main-content .article-metaline .article-meta-value')[1].text
		time = dom_tree.css('#main-container #main-content .article-metaline .article-meta-value')[2].text


		time = Time.parse(time).strftime("%Y%m%d%H%M%S").to_s
	    dict = time.to_s[0..3]+time.to_s[4..5]
	    now = Time.new.to_s[0..3]+Time.new.to_s[5..6]
	    #puts "----->#{time.to_i}"

        

		if time.to_i <= 20140816183000 
			#puts time.to_i <= 20140816183000
			#puts "ending"
			flag = true
			break
		end
		if File.exist?("page/#{time}.htm")
			exist_flag = exist_flag +1
			#puts "************#{exist_flag}"
			if exist_flag == 3
				flag = true
				break
			end
		end



		last_author = author 
		`wget -O page/#{time}.htm --load-cookies=cookie.txt -c https://www.ptt.cc#{x} --no-check-certifica`
		sleep(0.1)
		count = count +1
	    
	end
	if flag
		break
	end
end
`rm -rf index`
`rm -rf down`
`rm cookie.txt`
`rm over18`