from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os

session = HTMLSession()
filename = 'image.csv'
downloadfolder = 'LZZ3'
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
    print(SKU)
    for image in images:
        image_link=image.find('img')[0].attrs['src']
        #image_link = image[image.find('data-zoom-image')+17:image.find("'>")]
        image_link = image_link.replace('348_502','762_1100')
        item['image'+str(i)] = image_link
        i+=1
    print(item_link+'          '+ item['SKU'] + '   Image Count: '+str(i))    
    for i in range(0,len(item)-1):
        try:
            #print('SKU: '+ SKU)
            makemydir(folder+'/'+SKU)
            imgdownload = folder+'/'+SKU+'/'+item['image'+str(i)].split('/')[-1]
            urllib.request.urlretrieve(item['image'+str(i)],imgdownload)
            print('SKU: '+ SKU +'------ Image: '+item['image'+str(i)] + '------ Download: '+ imgdownload)
        except:
            print('Error - '+ SKU)
            pass        
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
        item_name = item.find('.product-item__info-title')[0].text
        item_link = 'https://adayroi.com'+item.find('.product-item__info-title')[0].attrs['href']
        item_price = item.find('.product-item__info-price-original')[0].text
        print(item_name)
        print(item_price)
        links.append(item_link)
    return links
    


urls = ['https://www.adayroi.com/tat-nam-co-dai-slazenger-md-1303-mau-xam-hang-chinh-hang-p-551297?offer=551297_126080&search=slazenger%201303',
'https://www.adayroi.com/tat-nam-co-dai-slazenger-md-1500-mau-xam-dam-hang-chinh-hang-p-551302?offer=551302_126080&search=slazenger%201500',
'https://www.adayroi.com/tat-nam-co-dai-slazenger-md-1600-mau-den-hang-chinh-hang-p-551305?offer=551305_126080&search=slazenger%201600',
'https://www.adayroi.com/tat-nam-co-vua-slazenger-mv-2500-mau-xam-chi-hang-chinh-hang-p-573033?offer=573033_126080&search=slazenger%202500',
'https://www.adayroi.com/tat-nam-co-vua-slazenger-mv-2600-mau-den-hang-chinh-hang-p-573039?offer=573039_126080&search=slazenger%202600',
'https://www.adayroi.com/tat-nam-co-vua-slazenger-mv-2611-mau-xam-phoi-den-hang-chinh-hang-p-573044?offer=573044_126080&search=slazenger%202611',
'https://www.adayroi.com/tat-nam-co-ngan-slazenger-mn-3000-mau-trang-hang-chinh-hang-p-551337?offer=551337_126080&search=slazenger%203000',
'https://www.adayroi.com/tat-nam-co-ngan-slazenger-mn-3300-mau-xam-dam-hang-chinh-hang-p-554709?offer=554709_126080&search=slazenger%203300',
'https://www.adayroi.com/tat-nam-co-ngan-slazenger-mn-3510-mau-xam-dam-ke-hang-chinh-hang-p-554723?offer=554723_126080&search=slazenger%203510',
'https://www.adayroi.com/tat-nam-co-ngan-slazenger-mn-3600-mau-den-hang-chinh-hang-p-554724?offer=554724_126080&search=slazenger%203600',
'https://www.adayroi.com/tat-nam-co-ngan-slazenger-mn-3650-mau-xam-phoi-den-hang-chinh-hang-p-554737?offer=554737_126080&search=slazenger%203650',
'https://www.adayroi.com/tat-nam-om-co-chan-slazenger-mc-5510-mau-xam-hang-chinh-hang-p-551278?offer=551278_126080&search=slazenger%205510',
'https://www.adayroi.com/tat-nam-om-co-chan-slazenger-mc-5600-mau-den-hang-chinh-hang-p-551279?offer=551279_126080&search=slazenger%205600',
'https://www.adayroi.com/tat-nam-om-co-chan-slazenger-mc-5650-mau-xam-phoi-den-hang-chinh-hang-p-551282?offer=551282_126080&search=slazenger%205650',
'https://www.adayroi.com/tat-ban-chan-nam-slazenger-mh-6000-mau-trang-hang-chinh-hang-p-551322?offer=551322_126080&search=slazenger%206000',
'https://www.adayroi.com/tat-ban-chan-nam-slazenger-mh-6330-mau-xam-hang-chinh-hang-p-551334?offer=551334_126080&search=slazenger%206330',
'https://www.adayroi.com/tat-ban-chan-nam-slazenger-mh-6600-mau-den-hang-chinh-hang-p-551336?offer=551336_126080&search=slazenger%206600',
'https://www.adayroi.com/tat-ban-chan-nu-slazenger-wh-6000-mau-xam-nhat-cham-bi-hang-chinh-hang-p-573048?offer=573048_126080&search=slazenger%206000',
'https://www.adayroi.com/tat-ban-chan-nu-slazenger-wh-6330-mau-xam-hang-chinh-hang-p-573051?offer=573051_126080&search=slazenger%206330',
'https://www.adayroi.com/tat-ban-chan-nu-slazenger-wh-6600-mau-den-hang-chinh-hang-p-573068?offer=573068_126080&search=slazenger%206600']


if __name__ == '__main__':
    pool = Pool(processes=8)
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