from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os


filename = 'image.csv'
downloadfolder = 'tiki'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder

def getImage(item_link):
	item = dict()
	session = HTMLSession()
	item_session = session.get(item_link)
	item_session.html.render(timeout=20,sleep=3,wait=2)
	SKU = item_session.html.find('.item-sku')[0].text
	item['SKU'] = SKU[SKU.find('\n')+1:]
	images = item_session.html.find('.flx')
	i = 0
	for image in images:
		image_link = image.find('img')[0].attrs['src']
		image_link = image_link.replace('75x75','w1200')
		item['image'+str(i)] = image_link
		i+=1
	print(item_link+'          '+ item['SKU'] + '   Image Count: '+str(i))  
	for i in range(0,len(item)-1):
		try:
			#print('SKU: '+ SKU)
			makemydir(folder+'/'+item['SKU'])
			imgdownload = folder+'/'+item['SKU']+'/'+item['image'+str(i)].split('/')[-1]
			print('SKU: '+ SKU +'------ Image: '+item['image'+str(i)] + '------ Downloading: '+ imgdownload)
			urllib.request.urlretrieve(item['image'+str(i)],imgdownload)           
		except:
			print('Error - '+ SKU)
			pass
	session.close()
	return item

def makemydir(whatever):
	try:
		os.makedirs(whatever)
	except OSError:
		pass
  # let exception propagate if we just can't
  # cd into the specified directory
	os.chdir(whatever)

urls = ['https://tiki.vn/bot-an-dam-nestle-cerelac-ga-ham-ca-rot-200g-p437935.html',
'https://tiki.vn/bot-an-dam-nestle-cerelac-gao-luc-tron-sua-200g-p437776.html',
'https://tiki.vn/bot-an-dam-nestle-cerelac-gao-va-trai-cay-200g-p437775.html',
'https://tiki.vn/bot-an-dam-nestle-cerelac-lua-mi-va-sua-200g-p437772.html',
'https://tiki.vn/bot-an-dam-nestle-cerelac-gao-sua-dinh-duong-200g-p1525569.html',
'https://tiki.vn/bot-an-dam-nestle-cerelac-rau-xanh-va-bi-do-200g-p437779.html',
'https://tiki.vn/banh-an-dam-nestle-cerelac-nutripuffs-vi-chuoi-cam-goi-50g-p578269.html',
'https://tiki.vn/banh-an-dam-nestle-cerelac-nutripuffs-vi-chuoi-dau-goi-50g-p578267.html',
'https://tiki.vn/san-pham-dinh-duong-nestle-nutren-junior-400g-p653872.html',
'https://tiki.vn/san-pham-dinh-duong-nestle-nutren-junior-800g-p653874.html'
]
if __name__ == '__main__':
    pool = Pool(processes=4)
    outputs = pool.map(getImage,urls)
    pool.close()
    pool.join()
    f = open(filename, "w", encoding="utf-8")
    f.write("")
    for item in outputs:
        print('SKU: '+ item['SKU'])
        f.write(item['SKU'])
        for i in range(0,len(item)-1):
            f.write('*'+item['image'+str(i)])
            print(' Image: '+item['image'+str(i)])
        f.write('\n')
    print('DONE')