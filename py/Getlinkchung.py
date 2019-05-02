from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os
import flickrapi
import flickr_download
flickr=flickrapi.FlickrAPI('11b99b3dea83234ce76bcd877a334c74', 'b12284268485a0c1', cache=True)

#--------------------------------CONFIG-----------------------------
debug = 1

url = ['NH25-17 - Xanh*https://www.flickr.com/photos/160396010@N02/46724755035/in/dateposted-public/',
'NH25-17 - Xanh*https://www.flickr.com/photos/160396010@N02/46724755035/in/dateposted-public/',
'NH25-17 - Hồng*https://www.flickr.com/photos/160396010@N02/33762989888/in/dateposted-public/',
'NH15-17 - Xanh*https://www.flickr.com/photos/160396010@N02/47640418471/in/dateposted-public/',
'NH15-17 - Hồng*https://www.flickr.com/photos/160396010@N02/47640418201/in/dateposted-public/',
'NH16-17 - Xanh*https://www.flickr.com/photos/160396010@N02/46724755685/in/dateposted-public/',
'NH16-17 - Hồng*https://www.flickr.com/photos/160396010@N02/40673812703/in/dateposted-public/',
'NH17-17 - Xanh*https://www.flickr.com/photos/160396010@N02/47640419511/in/dateposted-public/',
'NH17-17 - Hồng*https://www.flickr.com/photos/160396010@N02/33762990468/in/dateposted-public/',
'NH19-17 - Xanh*https://www.flickr.com/photos/160396010@N02/46724755415/in/dateposted-public/',
'NH19-17 - Hồng*https://www.flickr.com/photos/160396010@N02/46724755415/in/dateposted-public/',
]
downloadfolder = 'Nhat hoa 3'
filename= downloadfolder + '.csv'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder

#def
def getImage(params):
	if params.find('*') >0:
		item_link = params.split('*')[1]
		saveas = params.split('*')[0]
	else:
		item_link = params
		saveas = ''
	print('PROCESSING: '+ item_link)
	item = dict()
	if item_link.find('flickr.com') >=0:
		item['SKU'] = saveas
		photo_id = item_link.split('/')[5]
		a =	flickr.photos.getSizes(photo_id=photo_id)[0].find('./size/[@label="Original"]').attrib['source']
		item['image0'] = a
	else:
		session = HTMLSession()	
		item['SKU'] = saveas
		if item_link.find('adayroi.com') >=0:
			item_session = session.get(item_link)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			if saveas != '':
				item_SKU = item_session.html.find('.panel-serial-number')[0].text
				SKU = item_SKU[8:item_SKU.find(' - ')]
			#barcode = item_SKU[item_SKU.find('Mã SKU: ')+8:item_SKU.find(')')-1]
			#item['barcode'] = barcode
			item['SKU'] = SKU
			images = item_session.html.find('.theatre-image__list-item')
			#item['short_des'] = item_session.html.find('.short-des__content')[0].text
			#item['long_des'] = item_session.html.find('.product-detail__description')[0].text
			i = 0
			#print(SKU)
			if len(images) != 0:
				for image in images:
					image_link=image.find('img')[0].attrs['src']
					#image_link = image[image.find('data-zoom-image')+17:image.find("'>")]
					image_link = image_link.replace('348_502','762_1100')
					item['image'+str(i)] = image_link
					i+=1
				#print(item_link+'          '+ item['SKU'] + '   Image Count: '+str(i))    
			if len(images) == 0:
				images = item_session.html.find('.gallery-thumbnail__item-image')
				for image in images:
					image_link = image.attrs['data-zoom-image']
					item['image'+str(i)] = image_link
					i+=1
			#print(item_link+'          '+ item['SKU'] + '   Image Count: '+str(i))
		elif item_link.find('tiki') >= 0:
			item_session = session.get(item_link,verify = False)
			item_session.html.render()		
			if saveas != '':
				SKU = item_session.html.find('.item-sku')[0].text
				item['SKU'] = SKU[SKU.find('\n')+1:]
			images = item_session.html.find('.flx')
			i = 0
			for image in images:
				image_link = image.find('img')[0].attrs['src']
				image_link = image_link.replace('75x75','w1200')
				item['image'+str(i)] = image_link
				i+=1
		elif item_link.find('elmich.vn') >= 0:
			item_session = session.get(item_link)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('.lSGallery')[0].find('img')
			i = 0
			for image in images:
				image_link = image.find('img')[0].attrs['src']
				item['image'+str(i)] = 'https://elmich.vn'+ image_link
				i+=1
		elif item_link.find('lazada.vn') >=0:
			item_session = session.get(item_link)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('.item-gallery__thumbnail-image')
			i = 0
			for image in images:
				image_link = image.attrs['src']
				item['image'+str(i)] = 'https:'+image_link[:image_link.find('.jpg')+4]
				i+=1
		elif item_link.find('shopee.vn') >=0:
			item_session = session.get(item_link)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('._3XaILN')
			i = 0
			for image in images:
				a = image.attrs['style']
				item_link = a[a.find('url')+5:a.find(');')-1]
				item['image'+str(i)] = item_link[:-3]
				i+=1							
		elif item_link.find('noithathoanmy.com.vn') >=0:
			item_session = session.get(item_link)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('.flickity-lazyloaded')
			i = 0
			for image in images:
				a = image.attrs['src']
				item_link = a.replace('155755884cefe51827e3bd79057a4762','10f519365b01716ddb90abc57de5a837')
				item['image'+str(i)] = item_link
				i+=1	
		elif item_link.find('sapakitchen.vn') >=0:
			item_session = session.get(item_link)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('.slick-slide')
			i = 0
			for image in images:
				a = image.find('img')[0].attrs['src']
				item_link = a.replace('thumbs-428-428-0--1/','')
				item['image'+str(i)] = item_link
				i+=1
		elif item_link.find('nhuacholon') >= 0:
			item_session = session.get(item_link)
			item_session.html.render()
			images = item_session.html.find('.item_pic_thumb')
			i = 0
			for image in images:
				item['image'+str(i)] = 'http://nhuacholon.com.vn'+image.find('img')[0].attrs['src'].replace('thumbs/53_','')
				print(item['image'+str(i)])
				i+=1
			#print(str(SKU)+' - '+item_link)
		else:
			print("ERROR - Cant get link " + item_link )
		session.close()
	if len(item)>1:				
		for i in range(0,len(item)-1):
			try:
				if saveas == '':
					saveas = item['SKU']
				#print('SKU: '+ SKU)
				imgdownload = folder+'/'+saveas+'/'+item['image'+str(i)].split('/')[-1]
				#imgdownload = folder+'/'+barcode+'/'+SKU+'_'+str(i+1)+'.jpg'
				if os.path.exists(imgdownload) == False:
					try:
						makemydir(folder+'/'+saveas)
					except:
						pass
					print('SKU: '+ item['SKU'] +'------ Image: '+item['image'+str(i)] + '------ Downloading: '+ imgdownload)
					urllib.request.urlretrieve(item['image'+str(i)],imgdownload)           
			except Exception as e:
				print('Error '+ str(e) + ' - '+ item['image'+str(i)] + ' -- ' + imgdownload + ' -- ')
				pass	
	return item

def makemydir(whatever):
	try:
		if os.path.exists(whatever):
			pass
		else:
			os.makedirs(whatever)
	except:
		pass
  # let exception propagate if we just can't
  # cd into the specified directory
		os.chdir(whatever)

if debug == 0:
	if __name__ == '__main__':
		pool = Pool(processes=4)
		outputs = pool.map(getImage,url)
		pool.close()
		pool.join()
		f = open(filename, "w", encoding="utf-8")
		f.write("")
		for item in outputs:
			#print('SKU: '+ item['SKU'])
			f.write(item['SKU'])
			for i in range(0,len(item)-1):
				f.write('*'+item['image'+str(i)])
				#print(' Image: '+item['image'+str(i)])
			f.write('\n')
		print('DONE')
else:
	for i in url:
		getImage(i)
