from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os
import requests

__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
proxie = {'http':'http://10.220.85.82:9090','https':'http://10.220.85.82:9090',"ftp":'http://10.220.85.82:9090'}

folder = 'mango'

debug=0
filename = 'image.csv'
Error = []
items = []
try:
    with open(os.path.join(__location__,'mango.txt'),'r') as f:
        items = f.readlines()
except:
    print('Error open file')
    raise SystemExit()


def getImage(item_master):
    item_id=item_master.split('-')[0]
    item_color = item_master.split('-')[1]
    item_master = str(item_id)+'_'+str(item_color)
    if len(item_color) == 1:
        item_color = "0"+str(item_color)
    if os.path.isdir(folder+'/'+item_master):
        pass
    else:
        session = HTMLSession()
        item_link = 'https://shop.mango.com/vn/search?kw=' + str(item_id)
        item = dict()
        item_session = session.get(item_link,proxies = proxie)
        #item_session.html.render(timeout=20,sleep=3,wait=2)
        mother_url = item_session.html.url    
        mother_url = mother_url.split('?')[0]
        item_link = mother_url +'?c=' + str(item_color) +'&busqref=true'
        try:
            item_session = session.get(item_link,proxies = proxie)
            check_color = item_session.html.url
            check_color = check_color.split('?')[1].split('&')[0].split('=')[1]
            if check_color == item_color:
                item_session.html.render(timeout=20,sleep=3,wait=2)
                item['SKU'] = item_id
                item['Link'] = item_link
                images = item_session.html.find('.image-js')
                i = 0
                color_id = []
                for image in images:
                    image_link='https:'+image.attrs['src'][:image.attrs['src'].find('?')]
                    #image_link = image[image.find('data-zoom-image')+17:image.find("'>")]
                    item['image'+str(i)] = image_link
                    i+=1
                if i == 0:
                    try:
                        item_session = session.get(mother_url,proxies = proxie)
                        item_session.html.render(timeout=20,sleep=3,wait=2)
                        item['SKU'] = item_id
                        item['Link'] = item_link
                        colors = item_session.html.find('.color-container')
                        for color in colors:
                            color_id.append(color.attrs['id'])
                        if item_color in color_id:
                            images = item_session.html.find('.image-js')
                            i = 0
                            for image in images:
                                image_link='https:'+image.attrs['src'][:image.attrs['src'].find('?')]
                                #image_link = image[image.find('data-zoom-image')+17:image.find("'>")]
                                item['image'+str(i)] = image_link
                                i+=1
                        else:
                            Error.append(item_master)
                        #print(' Image : ' + image_link)
                    except:
                        print(item_link + '   ERROR')
                print(item_link+'    '+ item['SKU'] + '   Image Count: '+str(i) +'   Color found: '+str(color_id))    
                for i in range(0,len(item)-2):
                    try:
                        #print('SKU: '+ item_master)
                        makemydir(folder+'/'+item_master)
                        imgdownload = folder+'/'+item_master+'/'+item['image'+str(i)].split('/')[-1]
                        open(imgdownload,'wb').write(requests.get(item['image'+str(i)],proxies=proxie).content)      
                        #print('SKU: '+ item_master +'------ Image: '+item['image'+str(i)] + '------ Download: '+ imgdownload)
                    except:
                        #print()
                        pass
            else:
                print('Different: '+ check_color +'  -  '+item_color + ' - Link: ' +item_link)
            session.close()
            return item
        except:
            Error.append(item_master)
            print('Error 101: Cant find this item ' + str(item_master))
            pass      

def makemydir(whatever):
  try:
    os.makedirs(whatever)
  except OSError:
    pass
  # let exception propagate if we just can't
  # cd into the specified directory
  os.chdir(whatever)

def getlink(url):
    session = HTMLSession()
    links = []
    url_session = session.get(url,verify=False,proxies=proxie)
    url_session.html.render()
    items = url_session.html.find('.product-list-item')
    for item in items:
        item_link = item.find('.product-list-link')[0].attrs['href']
        links.append(item_link)
        print(item_link)
    session.close()
    return links

def getcolor(url):
    session = HTMLSession()
    url_color_id = []
    url_session = session.get(url,verify=False,proxies=proxie)
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
    session.close()
    return url_color_id

f = open(filename, "w", encoding="utf-8")
f.write("")
if debug == 0:
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
                for i in range(0,len(item)-2):
                    f.write('*'+item['image'+str(i)])                                       
            except:
                pass
            f.write('\n')
        print(str(Error))
        print('DONE')
else:
    for i in items:
        getImage(i)
