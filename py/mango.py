import requests
#from bs4 import BeautifulSoup as soup
import bs4

#url = 'https://moolez.vn/san-pham/bop-nam-4'
#headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}
#page = requests.get(url,headers = headers)
#soup = soup(page.text, 'html.parser')
#print(soup)
#sku = soup.findAll('span',{'class':'variant-sku'})[0].text
#images = soup.findAll('a',{'class':'thumb-link'})
#print(sku)
#for image in images:
#    link = 'https://moolez.vn/'+ image.get('data-zoom-image')
 #   print(link)

#for i in range (1,15):

filename = 'product.doc'
f = open(filename, "w", encoding="utf-8")
#headers = "Name,link\n"
f.write("")
for i in range(1,15):
    url = 'https://moolez.vn/san-pham/trang/'+str(i)+'/'
    print(url)
    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}
    page = requests.get(url,headers = headers)
    soup = bs4.BeautifulSoup(page.content, 'html.parser')
    #print(soup)
    items = soup.findAll('h2',{'class':'product-name'})
    for item in items:
        item_name = item.findAll('a')[0].get('title')
        link = item.findAll('a')[0].get('href')
        #print(link)
        f.write(link + "+")
        #print(item_page)
        page2 = requests.get(link,headers = headers)
        soup2 = bs4.BeautifulSoup(page2.content, 'html.parser')
        #print(soup2)
        skus = soup2.findAll('li',{'class':'variants-color'})
        #print(sku)
        for sku in skus:
            sku_name = sku.get('data-sku')
            print(sku_name)
            sku_image = sku.get('data-zoom-image')
            #print(sku_image)
            f.write(sku_name + "+")
        images = soup2.findAll('a',{'class':'thumb-link'})
    #print(sku)
        for image in images:
            imagelink = 'https://moolez.vn'+ image.get('data-zoom-image')
            #print(imagelink)
            f.write(imagelink+"+")
        #images = soup2.findAll('a',{'class':'thumb-link'})
        #print(sku)
        #for image in images:
        #    link = 'https://moolez.vn/'+ image.get('data-zoom-image')
        #    print(link)
        f.write("\n")
    url=""
    page=""
    soup=""
    item_name=""
    link=""
    page2=""
    soup2=""
f.close()