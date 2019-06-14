from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os
import flickrapi
import flickr_download
import pandas as pd
import time
flickr=flickrapi.FlickrAPI('11b99b3dea83234ce76bcd877a334c74', 'b12284268485a0c1', cache=True)

proxie = {'http':'http://10.220.85.82:9090','https':'http://10.220.85.82:9090',"ftp":'http://10.220.85.82:9090'}
import urllib.request
class AppURLopener(urllib.request.FancyURLopener):
    version = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0"
urllib._urlopener = AppURLopener()

session = HTMLSession()	

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

def paramsmaker(params):
	if params.find('*') >0:
		item_link = params.split('*')[1]
		saveas = params.split('*')[0]
	else:
		item_link = params
		saveas = ''
	return saveas,item_link

def getflickr(sku,link):	
	photo_id = link.split('/')[5]
	a =	flickr.photos.getSizes(photo_id=photo_id)[0].find('./size/[@label="Original"]').attrib['source']
	item['image0'] = a
	item['SKU'] = sku
	return item

def getdirectlink(sku,link):
	item = []
	item['SKU'] = sku
	link_split = link.split(';')
	for i,k in enumerate(link_split):
		item['image'+str(i)] = k
	return item

def makemydir(whatever):
	try:
		if os.path.exists(whatever):
			pass
		else:
			os.makedirs(whatever)
	except:
		print('Cant create folder: '+ whatever)
		pass

folder = 'C:/Users/minhcq/Desktop/download/lining'
skulist = ['AAPN015','AAPN019','AAPN019','AAPN153','AAYN017','ABAN045','ABPP037','AEKN027','AEKN027','AEKN027','AEKP007','AFJN008','AFJN023','AFJN024','AGAN004','AGAP005','AGAP005','AGAP005','AGAP006','AGAP006','AGAP006','AGBN013','AGBN044','AGBN057','AGCM055','AGCM076','AGCM174','AGCN063','AGCN086','AGCN136','AGCN151','AGCN158','AGCP007','AGCP013','AGCP013','AGCP043','AGGP003','AGGP011','AGLN068','AGLN117','AGLN159','AGLP005','AGLP019',
'AGLP019','AGLP032','AGLP039','AGWN032','AGWN053','AKQN076','AKQP011','AKQP042','AKSD127','AKSD127','AKSD135','AKSD135','AKSD135','AKSM235','AKSN056','AKSN072','AKSN086','AKSN109','AKSN109','AKSN115','AKSN119','AKSN119','AKSN123','AKSN127','AKSN135','AKSN175','AKSN193','AKSN193','AKSN193','AKSN229','AKSN235','AKSN235','AKSN247','AKSN247','AKSN655','AKSN655','AKSN655','AKSP016','AKSP016','AKSP029','AKSP033','AKSP043','AKSP043','AKSP065','AKSP065','AKSP073','AKSP083','AKSP098','AKSP098','AKSP167','AKSP169','AKSP169','AKSP169','AKSP169','AKSP171','AKSP171','AKSP171','AKSP585','AKSP589','AKSP589','AKSP603','AKSP603','AKSP613','AKSP613','AKSP613','AKSP615','AKSP615','AKSP615','AKSP615','ALSN005','ALSN005','ALSN005','ALSN006','ALSN007','ALSN008','ALSN008','ALSN027','ALSN031','ALSN033','ALSP005','ALSP007','ALSP007','ALSP007','APLD234','APLD234','APLD234','APLD236','APLD236','APLD249','APLN021','APLN026','APLN035','APLN041','APLN041','APLN043','APLN053','APLN053','APLN057','APLN059','APLN132','APLN132','APLN177','APLN177','APLN177','APLN183','APLN277','APLN277','APLN279','APLN313','APLN319','APLN321','APLP001','APLP014','APLP024','APLP028','APLP028','APLP032','APLP032','APLP033','APLP033','APLP033','APLP034','APLP034','APLP054','APLP063','APLP063','APLP075','APLP075','APLP091','APLP091','APLP091','APLP093','APLP093','APLP105','APLP105','APLP109','APLP111','APLP111','APLP111','APLP111','APLP113','APLP113','ARBM188','ARBN016','ARBN016','ARBN061','ARBN078','ARBP029','ARBP029','ARBP036','ARHM034','ARHN027','ARHN051','ARHN106','ARHN106','ARHN109','ARHN217','ARHP041','ARHP058','ARHP068','ARHP068','ARHP074','ARKN018','ARKN018','ARVN120','ARVN120','ARVN120','ARVN120','ARVN121','ARVN121','ARVP109','ARVP109','ARVP112','ARVP112','ARVP112','ARVP155','ARZN001','AUBP024','AUDL015','AUQN008','AUQN028','AUQN042','AUQP006','GLKN028','GLKN037','GLKN038','GLKN049','GLKN082','AAPN015','ABAM053','ABPM027','AFJN024','AGLN068','AKQN026','AKSN026','AKSN026','AKSN026','AKSN054','AKSN125','AKSN129','AKSP008','AKYN008','ALSN007','ALSN033','ALSN033','APLN025','APLN037','APLN057','APLN183','APLN183','GLKL016','GLKM072','GLSM002',]

urllist = ['https://lining.com.vn/products/nhan-ban-cua-giay-choi-bong-ro-nam-1',
'https://lining.com.vn/products/nhan-ban-cua-quan-tap-luyen-the-thao-nam-3',
'https://lining.com.vn/products/nhan-ban-cua-giay-chay-bo-the-thao-nu-11',
'https://lining.com.vn/products/giay-tap-luyen-the-thao-nam',
'https://lining.com.vn/products/nhan-ban-cua-giay-tap-luyen-the-thao-nu',
'https://lining.com.vn/products/dep-thoi-trang-nu',
'https://lining.com.vn/products/dep-thoi-trang-nu-4',
'https://lining.com.vn/products/nhan-ban-cua-giay-thoi-trang-the-thao-nu-10',
'https://lining.com.vn/products/nhan-ban-cua-giay-tap-luyen-the-thao-nam',
'https://lining.com.vn/products/nhan-ban-cua-giay-thoi-trang-the-thao-nam-14',
'https://lining.com.vn/products/nhan-ban-cua-giay-thoi-trang-the-thao-nam-15',
'https://lining.com.vn/products/giay-the-thao-nu-14',
'https://lining.com.vn/products/nhan-ban-cua-giay-thoi-trang-the-thao-nam-10',
'https://lining.com.vn/products/nhan-ban-cua-giay-thoi-trang-the-thao-nu-9',
'https://lining.com.vn/products/giay-thoi-trang-the-thao-nam-9',
'https://lining.com.vn/products/giay-thoi-trang-the-thao-nam-10',
'https://lining.com.vn/products/giay-thoi-trang-the-thao-nam-11',
'https://lining.com.vn/products/nhan-ban-cua-giay-thoi-trang-the-thao-nu-wukong-agln068',
'https://lining.com.vn/products/nhan-ban-cua-giay-thoi-trang-the-thao-nam-18',
'https://lining.com.vn/products/nhan-ban-cua-giay-thoi-trang-the-thao-nam',
'https://lining.com.vn/products/giay-thoi-trang-the-thao-nam-13',
'https://lining.com.vn/products/giay-thoi-trang-the-thao-nam-21',
'https://lining.com.vn/products/giay-thoi-trang-the-thao-nu-29',
'https://lining.com.vn/products/giay-thoi-trang-the-thao-nam-19',
'https://lining.com.vn/products/giay-the-thao-nu-20',
'https://lining.com.vn/products/giay-the-thao-nam-19',
'https://lining.com.vn/products/quan-the-thao-nam-59',
'https://lining.com.vn/products/nhan-ban-cua-quan-tap-luyen-the-thao-nam-7',
'https://lining.com.vn/products/quan-the-thao-nam-8',
'https://lining.com.vn/products/quan-the-thao-nam-9',
'https://lining.com.vn/products/quan-the-thao-nam-10',
'https://lining.com.vn/products/quan-tap-luyen-the-thao-nam',
'https://lining.com.vn/products/nhan-ban-cua-quan-tap-luyen-the-thao-nam-1',
'https://lining.com.vn/products/quan-tap-luyen-the-thao-nam-1',
'https://lining.com.vn/products/dep-the-thao-nam',
'https://lining.com.vn/products/dep-thoi-trang-nu-1',
'https://lining.com.vn/products/dep-the-thao-nam-4',
'https://lining.com.vn/products/dep-thoi-trang-nu-2',
'https://lining.com.vn/products/dep-the-thao-nam-1',
'https://lining.com.vn/products/dep-the-thao-nam-2',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nam',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nam-3',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nam-4',
'https://lining.com.vn/products/ao-cau-long-nam-20',
'https://lining.com.vn/products/ao-the-thao-nu-8',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nam-1',
'https://lining.com.vn/products/ao-the-thao-nam-17',
'https://lining.com.vn/products/ao-the-thao-nam-18',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nam-8',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nam-4',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nam-15',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nu-15',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nu-17',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nu-16',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nu-3',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nam-18',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nam-1',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nam-2',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nam-13',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nam-17',
'https://lining.com.vn/products/ao-thoi-trang-the-thao-nam-16',
'https://lining.com.vn/products/nhan-ban-cua-ao-thoi-trang-the-thao-nam-14',
'https://lining.com.vn/products/giay-chay-bo-nu-super-light-16',
'https://lining.com.vn/products/nhan-ban-cua-giay-chay-bo-the-thao-nam-7',
'https://lining.com.vn/products/giay-the-thao-nu-26',
'https://lining.com.vn/products/giay-chay-bo-nu-cloud-4chic',
'https://lining.com.vn/products/giay-the-thao-nam-37',
'https://lining.com.vn/products/nhan-ban-cua-giay-chay-bo-the-thao-nam-9',
'https://lining.com.vn/products/nhan-ban-cua-giay-chay-bo-the-thao-nu-13',
'https://lining.com.vn/products/giay-chay-bo-the-thao-nu-26',
'https://lining.com.vn/products/nhan-ban-cua-giay-chay-bo-the-thao-nu-14',
'https://lining.com.vn/products/giay-the-thao-nu-5',
'https://lining.com.vn/products/giay-chay-bo-nu-super-light-17',
'https://lining.com.vn/products/giay-cloud-lite-2019-chay-bo-nam',
'https://lining.com.vn/products/nhan-ban-cua-giay-chay-bo-the-thao-nam-20',
'https://lining.com.vn/products/ao-tap-luyen-the-thao-nu-2',
'https://lining.com.vn/products/giay-thoi-trang-the-thao-nu-13',
'https://lining.com.vn/products/giay-the-thao-nu',
'https://lining.com.vn/products/quan-the-thao-nu-13',
]

def getfindlining(x):
	url = 'https://lining.com.vn/search?type=product&q='+x
	content = session.get(url, proxies = proxie).html
	urllist.append('https://lining.com.vn'+content.find('div.product-item')[0].find('a')[0].attrs['href'])

def getlining(link):
	item={}
	try:
		content = session.get(link,verify=False,proxies = proxie).html
	except:
		time.sleep(2)
		#content = session.get(link,verify=False,proxies = proxie).html
	sku = content.find('.sku-number')[0].text.split('-')[0]
	if sku in skulist:
		item['SKU'] = sku
		a = 0
		for i in content.find('.thumbnail-item'):
			#item['SKU'] = sku +'-'+ i.attrs['data-alt']
			item['image' + str(a)] = 'http:'+ i.find('a')[0].attrs['href']
			a+=1
		return item
		#with open(folder+'/'+sku+'.txt','w',encoding = 'utf-8') as file:
		#for i in content.find('.swatch-element.color'):

def getitem(item,folder):
	try:
		if len(item)>1:
			for i in range(0,len(item)-1):
				try:
					#print('SKU: '+ SKU)
					imgdownload = folder+'/'+item['SKU']+'/'+item['image'+str(i)].split('/')[-1]
					#imgdownload = folder+'/'+barcode+'/'+SKU+'_'+str(i+1)+'.jpg'
					if os.path.exists(imgdownload) == False:
						try:
							makemydir(folder+'/'+item['SKU'])
						except:
							pass
						#print('SKU: '+ item['SKU'] +'------ Image: '+item['image'+str(i)] + '------ Downloading: '+ imgdownload)
						urllib.request.urlretrieve(item['image'+str(i)],imgdownload,proxies = proxie)           
				except Exception as e:
					print('Error')
					pass
	except:
		pass
'''
items = []
for i in urllist:
	items.append(getlining(i))
f = open('C:/Users/minhcq/Desktop/text.txt','w+')
f.write('SKU,image\r\n')
for item in items:
	try:
		if len(item)>1:
			f.write(item['SKU']+',')
			for i in range(len(item)-1):
				f.write(item['image'+str(i)]+',')
			f.write('\r\n')
	except:
		pass
f.close()		
#print(items)
#for i in items:
#	getitem(i,folder)
'''

urllib.request.urlretrieve(item['image'+str(i)],imgdownload,proxies = proxie)  