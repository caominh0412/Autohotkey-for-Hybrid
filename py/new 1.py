import bs4
import requests
from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup
from requests_html import HTMLSession
import getImage



session = HTMLSession()
urlcha = 'https://www.adayroi.com/l-occitane-br16959?page='
filename = 'adayroisua.doc'
f = open(filename, "w", encoding="utf-8")
f.write("")
for i in range(0,1):
	my_url = urlcha + str(i)
	print(my_url)
	print('Page:' + str(i))
	uClient = uReq(my_url)
	page_html = uClient.read()
	uClient.close()
	page_soup = soup(page_html,"html.parser")
	items=page_soup.findAll("div",{"class":"product-item__container"})
	#print('Tìm thấy ' + str(find_count))
	for item in items:
		#item_picture = items.findAll("a",{"class":"product-item__thumbnail"})
		item_name = item.findAll("a",{"class":"product-item__info-title"})[0].text
		item_link = 'https://adayroi.com'+item.findAll("a",{"class":"product-item__info-title"})[0].get('href')
		#item_link_search_pos = item_link.find('&search')
		#if item_link_search_pos != "":
		#	item_link = item_link[:item_link_search_pos]
		# item_price = item.div.div.span.text
		print("   Name: " + item_name)
		# print('Price:' + item_price)
		print('   Link:' + item_link)
		item = getImage(item_link)
		#long_description = item_soup.findAll('div',{'class':'product-detail__description'})[0].text
		#print("Short Desription: "+short_description)
		#print('Long Desription: '+ long_description)
		f.write(item_name + "*" + item_link + "\n")
f.close()