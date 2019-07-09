from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os
import flickrapi
import flickr_download
import pandas as pd
import requests
flickr=flickrapi.FlickrAPI('11b99b3dea83234ce76bcd877a334c74', 'b12284268485a0c1', cache=True)
proxie = {'http':'http://10.220.85.82:9090','https':'http://10.220.85.82:9090',"ftp":'http://10.220.85.82:9090'}





#--------------------------------CONFIG-----------------------------
debug = 0

headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.3'}



downloadfolder = 'cai gi day'
filename= downloadfolder + '.csv'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder

url = ['DXM*https://media.loveitopcdn.com/3558/dsc-1301.jpg;https://uphinh.org/image/6.Tcx4N;https://scontent-hkg3-1.xx.fbcdn.net/v/t1.0-9/35758834_2202792423081023_4857223509123792896_n.jpg?_nc_cat=100&_nc_oc=AQkRlK12Moacu-mqMwQy-MczEKIKoDndomcGS6crAp6O94n1eGgpLPwYe9ZW7-X0uwM&_nc_ht=scontent-hkg3-1.xx&oh=f6abf5f94b4ad59207ea34d4c1fe7a81&oe=5DB4EE06',
'BTTXM*https://www.xaphongthiennhien.vn/uploads/SP/14-1560912416.jpg;https://xomuopvilam.com/upload/hinhthem/bao-tay-tam1-7566.jpg;https://xomuopvilam.com/upload/hinhthem/bao-tay-tam-9708.png',
'TXM*https://cf.shopee.vn/file/ff4595144342a1ad53e48b8aba93193f;https://cf.shopee.vn/file/066588bad4a94d7447beabc509e71796;100',
'XMCC*https://uphinh.org/images/2019/06/20/7c21ee1f116598242.jpg;;100',
'XMCX*https://uphinh.org/images/2019/06/20/278b57a2fe9793af7.jpg;;100',
'XMRC*https://cf.shopee.vn/file/ee8301e908cddfe30f4213df0c953197;https://uphinh.org/images/2019/06/20/61.jpg;https://salt.tikicdn.com/cache/550x550/ts/product/8e/61/f2/43ae05fc9c6881ec2a0bf076ad51800e.jpg',
'5XMNT*https://uphinh.org/images/2019/06/20/21.jpg;;100',
'SDM*https://i-shop.vnecdn.net/resize/560/560/images/2018/07/31/5b60728730ba4-CG-VA-XM-50ML---Copy-2-.png;https://tea-1.lozi.vn/v1/images/resized/son-duong-moi-co-mau-dang-thoi-1521267425-1-5739999-1521267425?w=480&type=s;100',
'MCXP*;;100',
'MCTN*https://vn-test-11.slatic.net/p/d1846c8510a66301dc76bfcc5645ee67.jpg;https://vn-test-11.slatic.net/p/30908b32169acc7fd31aa8d65800c099.jpg;https://vn-test-11.slatic.net/p/4fcf188b2b5e525146490ba3f2edfb42.jpg',
'MDTN*https://vn-test-11.slatic.net/p/3104513a3f3ee9279d854550042bc298.jpg;;100',
'MOHTN*https://uphinh.org/images/2019/06/20/32.jpg;;100',
'MCRTN*https://uphinh.org/images/2019/06/20/31.jpg;;100',
'MTTN*https://uphinh.org/images/2019/06/20/29.jpg;;100',
'MNTN*https://uphinh.org/images/2019/06/20/30.jpg;;100',
'MHHTN*https://uphinh.org/images/2019/06/20/33.jpg;;100',
'MHNTN*https://uphinh.org/images/2019/06/20/34.jpg;;100',
'MLLTN*https://uphinh.org/images/2019/06/20/35.jpg;;100',

]


def passthing(excel):
	df = pd.read_excel(excel)
	df.dropna(axis=1,inplace=True,how='all')
	print(df.head())
	row = input('Columns :')
	df.columns=df.iloc[int(row)]
	for i in range(0,int(row)+1):
		df.drop(i,axis=0,inplace=True)
	print(df.columns)
	for i in df.columns:
		try:
			a = df[i].iloc[1]
			#print(a)
			if (a.find('https') >= 0):
				link = i
		except:
			continue
	return df,link

def getImg_frompandas(df,sku,link):
	item =[] 
	#return params = str(SKU) + "*" + str(link)
	for i in df.index:
		item.append("{}*{}".format(df[sku].loc[i],df[link].loc[i]))
	return item

#def
def getImage(params):
	if params.find('*') >0:
		item_link = params.split('*')[1]
		saveas = params.split('*')[0]
	else:
		item_link = params
		saveas = ''
	#print('PROCESSING: '+ item_link)
	item = dict()
	if item_link.find('flickr.com') >=0:
		item['SKU'] =saveas
		photo_id = item_link.split('/')[5]
		a =	flickr.photos.getSizes(photo_id=photo_id)[0].find('./size/[@label="Original"]').attrib['source']
		item['image0'] = a
	elif (item_link.find(';') >=0 ):
		item['SKU'] = saveas
		link_split = item_link.split(';')
		for i,k in enumerate(link_split):
			item['image'+str(i)] = k
	else:
		session = HTMLSession()	
		item['SKU'] = saveas
		if item_link.find('adayroi.com') >=0:
			item_session = session.get(item_link,proxies = proxie)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			try:
				if saveas != '':
					item_SKU = item_session.html.find('.panel-serial-number')[0].text
					SKU = item_SKU[8:item_SKU.find(' - ')]
					item['SKU'] = SKU
			except:
				item['SKU'] = saveas
				print('Loi ne ?' + saveas)
			#barcode = item_SKU[item_SKU.find('Mã SKU: ')+8:item_SKU.find(')')-1]
			#item['barcode'] = barcode
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
			item_session = session.get(item_link,verify = False,proxies = proxie)
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
			item_session = session.get(item_link,proxies = proxie)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('.lSGallery')[0].find('img')
			i = 0
			for image in images:
				image_link = image.find('img')[0].attrs['src']
				item['image'+str(i)] = 'https://elmich.vn'+ image_link
				i+=1
		elif item_link.find('lazada.vn') >=0:
			item_session = session.get(item_link,proxies = proxie)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('.item-gallery__thumbnail-image')
			i = 0
			for image in images:
				image_link = image.attrs['src']
				item['image'+str(i)] = 'https:'+image_link[:image_link.find('.jpg')+4]
				i+=1
		elif item_link.find('shopee.vn') >=0:
			item_session = session.get(item_link,proxies = proxie)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('._3XaILN')
			i = 0
			for image in images:
				a = image.attrs['style']
				item_link = a[a.find('url')+5:a.find(');')-1]
				item['image'+str(i)] = item_link[:-3]
				i+=1							
		elif item_link.find('noithathoanmy.com.vn') >=0:
			item_session = session.get(item_link,proxies = proxie)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('.flickity-lazyloaded')
			i = 0
			for image in images:
				a = image.attrs['src']
				item_link = a.replace('155755884cefe51827e3bd79057a4762','10f519365b01716ddb90abc57de5a837')
				item['image'+str(i)] = item_link
				i+=1	
		elif item_link.find('sapakitchen.vn') >=0:
			item_session = session.get(item_link,proxies = proxie)
			item_session.html.render(timeout=20,sleep=3,wait=2)
			images = item_session.html.find('.slick-slide')
			i = 0
			for image in images:
				a = image.find('img')[0].attrs['src']
				item_link = a.replace('thumbs-428-428-0--1/','')
				item['image'+str(i)] = item_link
				i+=1
		elif item_link.find('nhuacholon') >= 0:
			item_session = session.get(item_link,proxies = proxie)
			item_session.html.render()
			images = item_session.html.find('.item_pic_thumb')
			if images != '':
				i = 0
				for image in images:
					item['image'+str(i)] = 'http://nhuacholon.com.vn'+image.find('img')[0].attrs['src'].replace('thumbs/53_','')				
					print(item['image'+str(i)])
					i+=1
			else:
				item['image1'] = 'http://nhuacholon.com.vn' + item_session.html.find('.ad-image')[0].find('a')[0].attrs['href']
				print(item['image1'])
			#print(str(SKU)+' - '+item_link)
		elif item_link.find('handskid') >0:
			item_session = session.get(item_link,proxies = proxie)
			images = item_session.html.find('.product-block')
			i = 0
			for image in images:
				item_link = image.find('img')[0].attrs['src']
				if item_link.find('275')<0:
					item['image'+str(i)] = item_link.replace('483x483','700x700')
				i+=1
			if len(item)==1:
				item_session.html.render()
				x = item_session.html.find('.zoomWindowContainer')
				a = str(x[0].find('div')[1])
				item['image0'] = a[a.find('url')+5:a.find('");')]
		elif item_link.find('anmy') >0:
			item_session = session.get(item_link,verify = False,proxies = proxie)
			images = item_session.html.find('.thumbnail-item')
			i = 0
			for image in images:
				item_link = image.find('img')[0].attrs['src']
				item['image'+str(i)] ='https:' + item_link.replace('small','master')
				i+=1
		elif item_link.find('aokang') >0:
			item_session = session.get(item_link,verify = False,proxies = proxie)
			images = item_session.html.find('.slide')
			i = 0
			for image in images:
				item_link = image.attrs['data-thumb']
				item['image'+str(i)] ='https:' + item_link.replace('small','master')
				i+=1
		elif item_link.find('sprox') >0:
			item_session = session.get(item_link,verify = False,proxies = proxie)
			item_session.html.render()
			images = item_session.html.find('.thumb_item')
			if images == []:
				print('Cant get this link ' + item_link)
			i = 0
			for image in images:
				item_link = image.find('a')[0].attrs['data-zoom-image']
				item['image'+str(i)] ='https:' + item_link
				i+=1
		elif item_link.find('thecosmo.vn') >0:
			item_session = session.get(item_link,verify = False,proxies = proxie)
			#item_session.html.render()
			images = item_session.html.find('.fancybox-thumb')
			if images == []:
				print('Cant get this link ' + item_link)
			i = 0
			for image in images:
				item_link = image.attrs['href']
				item['image'+str(i)] ='https:' + item_link
				i+=1
		elif item_link.find('ktom') >0:
			item_session = session.get(item_link,verify = False,proxies = proxie)
			#item_session.html.render()
			images = item_session.html.find('div.item')
			if images == []:
				print('Cant get this link ' + item_link)
			i = 0
			for image in images:
				item_link = image.attrs['data-original']
				item['image'+str(i)] ='http://ktom.vn/' + item_link
				i+=1
		elif item_link.find('snbshop') >0:
			item_session = session.get(item_link,verify = False,proxies = proxie)
			#item_session.html.render()
			images = item_session.html.find('div.product-single__thumbnail')
			if images == []:
				print('Cant get this link ' + item_link)
			i = 0
			for image in images:
				item_link = image.attrs['data-img']
				item['image'+str(i)] ='http:' + item_link
				i+=1			
		else:
			print("ERROR - Cant get link " + item_link )
		session.close()
	if len(item)>1:				
		for i in range(0,len(item)-1):
			try:
				if saveas == '':
					saveas = item['SKU']
				#print('SKU: '+ SKU)
				imgname = str(i) + item['image'+str(i)].split('/')[-1]
				if imgname.find('?') > 0 :
					imgname = imgname.split('?')[0]
				imgdownload = folder+'/'+saveas+'/'+imgname
				#imgdownload = folder+'/'+barcode+'/'+SKU+'_'+str(i+1)+'.jpg'
				if os.path.exists(imgdownload) == False:
					try:
						makemydir(folder+'/'+saveas)
					except:
						pass
					#print('SKU: '+ item['SKU'] +'------ Image: '+item['image'+str(i)] + '------ Downloading: '+ imgdownload)
				open(imgdownload,'wb').write(requests.get(item['image'+str(i)],proxies=proxie,verify=False).content)          

			except Exception as e:
				print('Error '+ str(e) + ' - '+ item['image'+str(i)] + ' -- ' + imgdownload)
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
		#f = open(filename, "w", encoding="utf-8")
		#f.write("")
		#for item in outputs:
			#print('SKU: '+ item['SKU'])
		#	f.write(item['SKU'])
		#	for i in range(0,len(item)-1):
		#		f.write('*'+item['image'+str(i)])
				#print(' Image: '+item['image'+str(i)])
		#	f.write('\n')
		print('DONE')
elif debug == 1:
	for i in url:
		getImage(i)

else:
	excel = input('Excel: ')
	df,linkCol = passthing(excel)
	skuCol = input('Cot SKU: ')  
	#linkCol = input('Cot link: ')
	item = getImg_frompandas(df,skuCol,linkCol)
	for i in item:
		getImage(i)
	print('DONE')
