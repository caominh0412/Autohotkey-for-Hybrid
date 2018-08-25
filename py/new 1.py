import bs4
import requests
from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup
from requests_html import HTMLSession
from getImage import getImage



session = HTMLSession()
urlcha = 'https://www.adayroi.com/TAN-HOANG-mc1552?page='
filename = 'TAN HOANG.csv'
f = open(filename, "w", encoding="utf-8")
f.write("")
for i in range(0,8):
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
		item_price = item.findAll('span',{'class':'product-item__info-price-original'})
		#print(item_price)
		#print(len(item_price))
		item_price_found = len(item_price)
		if item_price_found == 0 :
			item_price = item.findAll('span',{'class':'product-item__info-price-sale'})[0].text
		else:
			item_price = item.findAll('span',{'class':'product-item__info-price-original'})[0].text
		#item_link_search_pos = item_link.find('&search')
		#if item_link_search_pos != "":
		#	item_link = item_link[:item_link_search_pos]
		#item_price = item.div.div.span.text
		print("   Name: " + item_name)
		print('   Price:' + item_price)
		print('   Link:' + item_link)
		SKU = item_link[-len(item_link)+item_link.find('offer=')+6:]
		print('   SKU: '+SKU)
		#item = getImage(item_link)
		#long_description = item_soup.findAll('div',{'class':'product-detail__description'})[0].text
		#print("Short Desription: "+short_description)
		#print('Long Desription: '+ long_description)
		#f.write(item['SKU'])
		#for i in range(0,len(item)-1):
		#	f.write('*'+item['image'+str(i)])
		#	print(' Image: '+item['image'+str(i)])
		f.write(SKU+"*"+ item_name+"*"+item_price+"\n")
f.close()