import bs4
import requests
from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup

my_url = 'https://www.adayroi.com/TRIUMPH-mc13257?q=&page=0'
print(my_url)
uClient = uReq(my_url)
page_html = uClient.read()
uClient.close()
page_soup = soup(page_html,"html.parser")
#find_count = page_soup.findAll('span',{'class':'header__search-result'})[0].text.strip('Tìm thấy sản phẩm')
items=page_soup.findAll("div",{"class":"product-item__container"})
filename = 'product_1.doc'
f = open(filename, "w", encoding="utf-8")
headers = "Name,Price\n"
f.write("")
#print('Tìm thấy ' + str(find_count))
for item in items:
	#item_picture = items.findAll("a",{"class":"product-item__thumbnail"})
	item_name = item.findAll("a",{"class":"product-item__info-title"})[0].text
	item_link = 'https://adayroi.com'+item.findAll("a",{"class":"product-item__info-title"})[0].get('href')
	#item_link_search_pos = item_link.find('&search')
	#if item_link_search_pos != "":
	#	item_link = item_link[:item_link_search_pos]
	item_price = item.div.div.span.text
	print("Name: " + item_name)
	print('Price:' + item_price)
	print('Link:' + item_link)
	uClient = uReq(item_link)
	item_html = uClient.read()
	uClient.close
	item_soup = soup(item_html,'html.parser')
	short_description = item_soup.findAll('li',{'class':'nobullet'})[0].text
	ID = item_soup.findAll('span',{'class':'panel-serial-number'})[0].text
	item_images = item_soup.findAll('div',{'data-type':'image'})
	f.write(item_name + "+" + item_link + "+" + ID  )
	for item_image in item_images:
		image_link = item_image.get('data-zoom-image')
		f.write("+" + image_link)
	f.write("\n")
	#long_description = item_soup.findAll('div',{'class':'product-detail__description'})[0].text
	#print("Short Desription: "+short_description)
	#print('Long Desription: '+ long_description)
	#f.write(item_name + "+" +item_price + "+" + item_link + "+" + short_description + "+" + long_description + "\n")

f.close()