from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os


filename = 'image.csv'
downloadfolder = 'tinhdaugold'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder


def getImage(item_link):
    item = dict()
    session = HTMLSession()
    item_session = session.get(item_link)
    item_session.html.render(timeout=20,sleep=3,wait=2)
    item_SKU = item_session.html.find('.panel-serial-number')[0].text
    SKU = item_SKU[8:item_SKU.find(' - ')]
    barcode = item_SKU[item_SKU.find('Mã SKU: ')+8:]
    item['SKU'] = SKU
    images = item_session.html.find('.theatre-image__list-item')
    i = 0
    #print(SKU)
    if len(images) != 0:
        for image in images:
            image_link=image.find('img')[0].attrs['src']
            #image_link = image[image.find('data-zoom-image')+17:image.find("'>")]
            image_link = image_link.replace('348_502','762_1100')
            item['image'+str(i)] = image_link
            i+=1
        print(item_link+'          '+ item['SKU'] + '   Image Count: '+str(i))    
    if len(images) == 0:
        images = item_session.html.find('.gallery-thumbnail__item-image')
        for image in images:
            image_link = image.attrs['data-zoom-image']
            item['image'+str(i)] = image_link
            i+=1
        print(item_link+'          '+ item['SKU'] + '   Image Count: '+str(i))
    for i in range(0,len(item)-1):
        try:
            #print('SKU: '+ SKU)
            makemydir(folder+'/'+barcode)
            imgdownload = folder+'/'+barcode+'/'+item['image'+str(i)].split('/')[-1]
            print('SKU: '+ SKU +'------ Image: '+item['image'+str(i)] + '------ Downloading: '+ imgdownload)
            urllib.request.urlretrieve(item['image'+str(i)],imgdownload)           
        except:
            print('Error - '+ SKU)
            pass
    session.close()
    return item

def getPrice(item_link):
    session = HTMLSession()
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
    session = HTMLSession()
    url_session = session.get(url)
    totalpage = url_session.html.find('a[aria-label="Next"]')[0].attrs['href']
    totalpage = int(totalpage[-len(totalpage)+totalpage.find('page=')+5:])+1
    print('Total page= ' + str(totalpage))
    return totalpage

def getlink(url):
    session = HTMLSession()
    links = []
    url_session = session.get(url)
    items = url_session.html.find('.product-item__container')
    for item in items:
        item_name = item.find('.product-item__info-title')[0].text
        item_link = 'https://adayroi.com'+item.find('.product-item__info-title')[0].attrs['href']
        #item_price = item.find('.product-item__info-price-original')[0].text
        print(item_name)
        #print(item_price)
        links.append(item_link)
    return links
    


urls = [
'https://www.adayroi.com/p/1845461',
'https://www.adayroi.com/p/1852029',
'https://www.adayroi.com/p/1845461',
'https://www.adayroi.com/p/1852020',
'https://www.adayroi.com/p/1845461',
'https://www.adayroi.com/p/1852025',
'https://www.adayroi.com/p/1845462',
'https://www.adayroi.com/p/1852029',
'https://www.adayroi.com/p/1845462',
'https://www.adayroi.com/p/1852020',
'https://www.adayroi.com/p/1845462',
'https://www.adayroi.com/p/1852025',
'https://www.adayroi.com/p/1862000',
'https://www.adayroi.com/p/1845788',
'https://www.adayroi.com/p/1862000',
'https://www.adayroi.com/p/1845800',
'https://www.adayroi.com/p/1862000',
'https://www.adayroi.com/p/1845831',
'https://www.adayroi.com/p/1845306',
'https://www.adayroi.com/p/1845305',
'https://www.adayroi.com/p/1845310',
'https://www.adayroi.com/p/PRI1257854',
'https://www.adayroi.com/p/1845306',
'https://www.adayroi.com/p/PRI1257854',
'https://www.adayroi.com/p/1845305',
'https://www.adayroi.com/p/PRI1257892',
'https://www.adayroi.com/p/1845306',
'https://www.adayroi.com/p/PRI1257892',
'https://www.adayroi.com/p/1845305',
'https://www.adayroi.com/p/PRI1257892',
'https://www.adayroi.com/p/PRI1262681',
'https://www.adayroi.com/p/PRI1257854',
'https://www.adayroi.com/p/PRI1262681',
'https://www.adayroi.com/p/PRI1265167',
'https://www.adayroi.com/p/PRI1264782',
'https://www.adayroi.com/p/PRI1264906',
'https://www.adayroi.com/p/PRI1265491',
'https://www.adayroi.com/p/PRI1264906',
'https://www.adayroi.com/p/PRI1264702',
'https://www.adayroi.com/p/PRI1264906',
'https://www.adayroi.com/p/PRI1264908',
'https://www.adayroi.com/p/PRI1264945',
'https://www.adayroi.com/p/PRI1265491',
'https://www.adayroi.com/p/PRI1264945',
'https://www.adayroi.com/p/PRI1264702',
'https://www.adayroi.com/p/PRI1264945',
'https://www.adayroi.com/p/PRI1264908',

]



if __name__ == '__main__':
    for url in urls:
        getImage(url)

    print('DONE')