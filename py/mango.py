from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os

session = HTMLSession()
filename = 'image.csv'
items =['https://shop.mango.com/vn/women/cardigans-and-sweaters-sweaters/cable-knit-sweater_13020387.html?c=91',
'https://shop.mango.com/vn/women/cardigans-and-sweaters-sweaters/cable-knit-sweater_13020387.html?c=96',
'https://shop.mango.com/vn/boys/sweatshirts/striped-cotton-blend-sweatshirt_13020398.html?c=52',
'https://shop.mango.com/vn/women/coats-trench-coats/flared-sleeve-trench_13020422.html?c=08',
'https://shop.mango.com/vn/women/t-shirts-and-tops-short-sleeve/printed-cotton-t-shirt_13020426.html?c=02',
'https://shop.mango.com/vn/women/t-shirts-and-tops-short-sleeve/printed-cotton-t-shirt_13020426.html?c=43',
'https://shop.mango.com/vn/men/shoes-sneakers/lace-up-canvas-sneakers_13020432.html?c=52',
'https://shop.mango.com/vn/men/shoes-sneakers/lace-up-canvas-sneakers_13020432.html?c=99',
'https://shop.mango.com/vn/men/shoes-boots-and-ankle-boots/lace-up-leather-boots_13020433.html?c=01',
'https://shop.mango.com/vn/boys/sweatshirts/hoodie-cotton-sweatshirt_13020438.html?c=56',
'https://shop.mango.com/vn/boys/jogging/camo-print-jogging-trousers_13020439.html?c=37',
'https://shop.mango.com/vn/women/jewellery-necklaces/pendant-chain-necklace_13020445.html?c=PL',
'https://shop.mango.com/vn/boys/sweatshirts/kangaroo-pocket-hoodie_13020446.html?c=37',
'https://shop.mango.com/vn/boys/sweatshirts/kangaroo-pocket-hoodie_13020446.html?c=56',
'https://shop.mango.com/vn/girls/shirts/openwork-detail-blouse_13020458.html?c=02',
'https://shop.mango.com/vn/girls/shirts/textured-cotton-shirt_13020459.html?c=02',
'https://shop.mango.com/vn/girls/shirts/textured-cotton-shirt_13020459.html?c=82',
'https://shop.mango.com/vn/girls/shirts/ruched-sleeve-blouse_13020460.html?c=70',
'https://shop.mango.com/vn/girls/shirts/ruched-sleeve-blouse_13020460.html?c=95',
'https://shop.mango.com/vn/men/t-shirts-plain/strap-t-shirt_13020462.html?c=43',
'https://shop.mango.com/vn/men/t-shirts-plain/strap-t-shirt_13020462.html?c=56',
'https://shop.mango.com/vn/men/t-shirts-printed/striped-cotton-t-shirt_13020474.html?c=56',
'https://shop.mango.com/vn/girls/t-shirts-short-sleeve/feather-t-shirt_13020478.html?c=05',
'https://shop.mango.com/vn/women/jumpsuits-long/cotton-print-jumpsuit_13020487.html?c=02',
'https://shop.mango.com/vn/women/jackets-biker-jackets/medium-denim-jacket_13020497.html?c=TC',
'https://shop.mango.com/vn/women/bags-shoppers/leather-hobo-bag_13020506.html?c=70',
'https://shop.mango.com/vn/boys/jeans/slim-fit--jeans_13020525.html?c=TM',
'https://shop.mango.com/vn/boys/jeans/slim-fit--jeans_13020525.html?c=TO',
'https://shop.mango.com/vn/girls/jeans/slim-fit--jeans_13020543.html?c=TG',
'https://shop.mango.com/vn/women/skirts-short/tie-dye-denim-skirt_13020554.html?c=TM',
'https://shop.mango.com/vn/boys/sweatshirts/printed-cotton-sweatshirt_13020566.html?c=94',
'https://shop.mango.com/vn/girls/jackets/bomber-jacket_13020570.html?c=37',
'https://shop.mango.com/vn/girls/jackets/bomber-jacket_13020570.html?c=99',
'https://shop.mango.com/vn/girls/scarves-and-hats-hats/message-ribbed-hat_13020571.html?c=52',
'https://shop.mango.com/vn/women/bags-shoppers/floral-embroidery-shopper-bag_13020579.html?c=99',
'https://shop.mango.com/vn/women/dresses-short/ruffled-chiffon-dress_13020597.html?c=99',
'https://shop.mango.com/vn/girls/shirts/ruffle-vichy-blouse_13020608.html?c=50',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/essential-cotton-t-shirt_13020630.html?c=02',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/essential-cotton-t-shirt_13020630.html?c=05',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/essential-cotton-t-shirt_13020630.html?c=15',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/essential-cotton-t-shirt_13020630.html?c=56',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/henley-t-shirt_23020682.html?c=02',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/henley-t-shirt_23020682.html?c=56',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/henley-t-shirt_23020682.html?c=69',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/henley-t-shirt_23020682.html?c=70',
'https://shop.mango.com/vn/boys/t-shirts-long-sleeve/henley-t-shirt_23020682.html?c=95',
'https://shop.mango.com/vn/women/wallets-and-cases/zipped-cosmetic-bag_13020634.html?c=20',
'https://shop.mango.com/vn/women/wallets-and-cases/zipped-cosmetic-bag_13020634.html?c=37',
'https://shop.mango.com/vn/girls/leggings/denim-leggings_13020652.html?c=TG',
'https://shop.mango.com/vn/girls/leggings/denim-leggings_13020652.html?c=TM',
]

def getImage(item_link):
    downloadfolder = 'mango2'
    folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder
    item = dict()
    item_session = session.get(item_link)
    item_session.html.render(timeout=20,sleep=3,wait=2)
    try:
        SKU = item_session.html.find('.product-reference')[0].text
        item['SKU'] = SKU[5:13]
        item['Link'] = item_link
        if item['SKU'] == '':
            item['SKU'] = item_link[item_link.find('_')+1:item_link.find('_')+9]
    except:
        print(item_link + '    Error - Cant find SKU')
        item['SKU'] = item_link[item_link.find('_')+1:item_link.find('_')+9]
    images = item_session.html.find('.image-js')
    i = 0
    for image in images:
        image_link='http:'+image.attrs['src'][:image.attrs['src'].find('?')]
        #image_link = image[image.find('data-zoom-image')+17:image.find("'>")]
        item['image'+str(i)] = image_link
        i+=1
        #print(' Image : ' + image_link)
    print(item_link+'          '+ item['SKU'] + '   Image Count: '+str(i))    
    for i in range(0,len(item)-1):
        try:
            mamau_jpg = item['image'+str(i)].split('/')[-1]
            mamau = mamau_jpg.replace('.jpg','')
            mamau = mamau.replace('-99999999','')
            SKU_mamau = mamau.split('_')[0]+'_'+mamau.split('_')[1]
            if mamau in item['SKU']:
                print('SKU: '+ SKU_mamau)
                makemydir(folder+'/'+SKU_mamau)
                imgdownload = folder+'/'+SKU_mamau+'/'+item['image'+str(i)].split('/')[-1]
                urllib.request.urlretrieve(item['image'+str(i)],imgdownload)
                print('SKU: '+ SKU_mamau +'------ Image: '+item['image'+str(i)] + '------ Download: '+ imgdownload)
            else:
                print('SKU: '+ item['SKU']+'_'+mamau.split('_')[1])
                makemydir(folder+'/'+item['SKU']+'_'+mamau.split('_')[1])
                imgdownload = folder+'/'+item['SKU']+'_'+mamau.split('_')[1]+'/'+item['image'+str(i)].split('/')[-1]
                urllib.request.urlretrieve(item['image'+str(i)],imgdownload)
                print('SKU: '+ item['SKU']+'_'+mamau.split('_')[1]+ '------ Image: '+item['image'+str(i)] + '------ Download: '+ imgdownload)
        except:
            print()
            pass
    return item

def makemydir(whatever):
  try:
    os.makedirs(whatever)
  except OSError:
    pass
  # let exception propagate if we just can't
  # cd into the specified directory
  os.chdir(whatever)

def getlink(url):
    links = []
    url_session = session.get(url,verify=False)
    url_session.html.render()
    items = url_session.html.find('.product-list-item')
    for item in items:
        item_link = item.find('.product-list-link')[0].attrs['href']
        links.append(item_link)
        print(item_link)
    return links

def getcolor(url):
    url_color_id = []
    url_session = session.get(url,verify=False)
    url_session.html.render()
    colors = url_session.html.find('.color-container')
    print(url)
    #print(str(colors))
    for color in colors:
        try:
            color_id = color.attrs['id']
            print('    '+color_id)
            url_color = url+'?c='+ color_id
            url_color_id.append(url_color)
        except:
            pass
    return url_color_id

f = open(filename, "w", encoding="utf-8")
f.write("")
if __name__ == '__main__':
    #    print('Page '+str(i-1))
    #    urlpage = url +'?page='+str(i-1)
    #    print(urlpage)
    #    items = items + getlink(urlpage)
    # get color
    #url_list = []
    pool = Pool(processes=4)
    #for item in items:
    #    url_list = url_list + getcolor(item)
    outputs = pool.map(getImage,items)
    pool.close()
    pool.join()
    pool.close()
    for item in outputs:
        try:
            f.write(item['SKU'])
            f.write('*'+ item['Link'])
            #print(imgdownload)
            #makemydir(folder+'/'+item['SKU'])
            for i in range(0,len(item)-1):
                f.write('*'+item['image'+str(i)])                                       
        except:
            pass
        f.write('\n')
    print('DONE')