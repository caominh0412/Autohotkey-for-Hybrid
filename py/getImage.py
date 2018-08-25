from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os

session = HTMLSession()
filename = 'image.csv'
downloadfolder = 'test'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder


def getImage(item_link):
    item = dict()
    item_session = session.get(item_link)
    item_session.html.render()
    SKU = item_session.html.find('.panel-serial-number')[0].text
    SKU = SKU[8:SKU.find(' - ')]
    item['SKU'] = SKU
    images = item_session.html.find('.theatre-image__list-item')
    i = 0
    for image in images:
        image_link=image.find('img')[0].attrs['src']
        #image_link = image[image.find('data-zoom-image')+17:image.find("'>")]
        image_link = image_link.replace('348_502','762_1100')
        item['image'+str(i)] = image_link
        i+=1
        #print(' Image : ' + image_link)
    #print(SKU)
    return item

def getPrice(item_link):
    item = dict()
    item_session = session.get(item_link)
    item_session.html.render()
    SKU = item_session.html.find('.panel-serial-number')[0].text
    SKU = SKU[8:SKU.find(' - ')]
    item['SKU'] = SKU
    item['price'] = item_session.html.find('.price-info__original')[0].text
    print('SKU: ' + item['SKU'] + '- Price:' + item['price'])
    return item

def makemydir(whatever):
  try:
    os.makedirs(whatever)
  except OSError:
    pass
  # let exception propagate if we just can't
  # cd into the specified directory
  os.chdir(whatever)


def gettotalpage(url):
    url_session = session.get(url)
    totalpage = url_session.html.find('a[aria-label="Next"]')[0].attrs['href']
    totalpage = int(totalpage[-len(totalpage)+totalpage.find('=')+1:])+1
    print('Total page= ' + str(totalpage))
    return totalpage

def getlink(url):
	links = []
	url_session = session.get(url)
	items = url_session.html.find('.product-item__container')
	for item in items:
    #    item_name = item.find('.product-item__info-title')[0].text
		item_link = 'https://adayroi.com'+item.find('.product-item__info-title')[0].attrs['href']
    #    print(item_name)
		links.append(item_link)
	return links
    

urls = ['https://www.adayroi.com/sua-bot-abbott-ensure-gold-huong-vani-850g-p-PRI1054935?offer=PRI1054935_LZZ',
'https://www.adayroi.com/hop-qua-abbott-gom-2-lon-sua-bot-vani-ensure-gold-850g-va-2-chai-sua-nuoc-ensure-gold-vigor-237ml-p-PRI1054973?offer=PRI1054973_LZZ']

if __name__ == '__main__':
    pool = Pool(processes=4)
    outputs = pool.map(getImage,urls)
    pool.close()
    pool.join()
    pool.close()
    f = open(filename, "w", encoding="utf-8")
    f.write("")
    for item in outputs:
        print('SKU: '+ item['SKU'])
        f.write(item['SKU'])
        for i in range(0,len(item)-1):
            f.write('*'+item['image'+str(i)])
            print(' Image: '+item['image'+str(i)])
            imgdownload = folder+'/'+item['SKU']+'/'+item['SKU']+'_'+str(i+1)+'.jpg'
            #print(imgdownload)
            makemydir(folder+'/'+item['SKU'])
            urllib.request.urlretrieve(item['image'+str(i)],imgdownload)
        f.write('\n')
    print('DONE')

