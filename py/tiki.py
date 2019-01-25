from requests_html import HTMLSession
from multiprocessing import Pool 
import urllib.request
import os


filename = 'image.csv'
downloadfolder = 'tiki'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder

def getImage(item_link):
	item = dict()
	item['SKU']=item_link.split('*')[0]
	item_link = item_link.split('*')[1]
	if item_link.find('jpg')<0 and item_link.find('tiki') >0:
		session = HTMLSession()
		item_session = session.get(item_link)
		item_session.html.render(timeout=20,sleep=3,wait=2)
		if item['SKU'] == '':
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
				if len(item)-1 >= 3:
					makemydir(folder+'/3 anh/'+item['SKU'])
					imgdownload = folder+'/3 anh/'+'/'+item['SKU']+'/'+item['image'+str(i)].split('/')[-1]
					#print('SKU: '+ item['SKU'] +'------ Image: '+item['image'+str(i)] + '------ Downloading: '+ imgdownload)
					urllib.request.urlretrieve(item['image'+str(i)],imgdownload)
				else:
					makemydir(folder+'/it hon 3 anh/'+item['SKU'])
					imgdownload = folder+'/it hon 3 anh/'+'/'+item['SKU']+'/'+item['image'+str(i)].split('/')[-1]
					#print('SKU: '+ item['SKU'] +'------ Image: '+item['image'+str(i)] + '------ Downloading: '+ imgdownload)
					urllib.request.urlretrieve(item['image'+str(i)],imgdownload)
			except:
				print('Error - '+ SKU)
				pass
		session.close()
	else:
		makemydir(folder+'/it hon 3 anh/'+item['SKU'])
		imgdownload = folder+'/it hon 3 anh/'+'/'+item['SKU']+'/'+item_link.split('/')[-1]
		try:
			urllib.request.urlretrieve(item_link,imgdownload)
		except:
			print('Cant download '+ item_link)
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

urls = ['3337871310455_PYE*https://tiki.vn/kem-khu-mui-giup-kho-thoang-vung-da-duoi-canh-tay-chuyen-sau-vichy-7-days-anti-perspirant-cream-treatment-intensive-perspiration-30ml-p1629087.html?spid=6971491',
'3337875553155_PYE*https://tiki.vn/xit-khu-mui-giau-khoang-giup-vung-da-duoi-canh-tay-kho-thoang-vichy-deodorant-mineral-125ml-p1628063.html?src=search&keyword=X%E1%BB%8Bt+Kh%E1%BB%AD+M%C3%B9i+Gi%C3%A0u+Kho%C3%A1ng%2C+Gi%C3%BAp+V%C3%B9ng+Da+D%C6%B0%E1%BB%9Bi+C%C3%A1nh+Tay+Kh%C3%B4+Tho%C3%A1ng+Vichy+D%C3%89ODORANT+MIN%C3%89RAL+125ml',
'3337871310462_PYE*https://tiki.vn/kem-khu-mui-va-giup-duong-da-mem-min-cho-da-nhay-cam-vichy-24hr-cream-deodorant-sensitive-or-depilated-skin-40ml-p1628061.html?spid=6971487',
'3337871320300_PYE*https://tiki.vn/lan-khu-mui-giup-kho-thoang-vung-da-duoi-canh-tay-48h-vichy-traitement-anti-transpirant-48h-50ml-p1628057.html?spid=6971485',
'3337871324001_PYE*https://tiki.vn/lan-khu-mui-giup-kho-thoang-vung-da-duoi-canh-tay-72h-vichy-detransprirant-intensif-72h-transpiration-excessive-50ml-p1628055.html?spid=6971483',
'3337871323394_PYE*https://tiki.vn/dau-goi-dac-tri-gau-danh-cho-da-dau-nhay-cam-vichy-dt-antipel-chute-200ml-100891276-p413646.html?spid=6971429',
'3337871311292_PYE*https://tiki.vn/dau-goi-tang-cuong-duong-chat-giup-giam-rung-toc-vichy-dercos-energising-shampoo-hairloss-100738876-200ml-p719718.html?spid=6971329',
'3337871325770_PYE*https://tiki.vn/chai-xit-chong-nang-lau-troi-spf50-vichy-100651052-200ml-p429036.html?spid=6970703',
'3337875419802_PYE*https://tiki.vn/kem-chong-nang-ngan-sam-da-giam-tham-nam-vichy-spf50-chong-tia-uva-100791635-p505915.html?spid=6970699',
'3337871324865_PYE*https://tiki.vn/gel-se-khit-lo-chan-long-giai-doc-thanh-loc-ban-dem-vichy-normaderm-night-detox-100758060-40ml-p413766.html?spid=6970353',
'3337871322519_PYE*https://tiki.vn/gel-rua-mat-ngan-ngua-mun-normaderm-deep-cleansing-purifying-gel-vichy-100ml-100758057-p411713.html?spid=6970351',
'3337871324506_PYE*https://tiki.vn/gel-dac-tri-mun-hieu-qua-nhanh-normaderm-hyaluspot-vichy-15ml-100569703-p411725.html?spid=6970349',
'3337871309305_PYE*https://tiki.vn/but-ngan-ngua-giam-mun-va-che-vet-tham-normaderm-concentrated-stick-vichy-0-25g-100788415-p411727.html?spid=6970347',
'3337871322328_PYE*https://tiki.vn/sua-rua-mat-tao-bot-ngan-ngua-mun-va-se-lo-chan-long-normaderm-anti-perfection-deep-cleansing-foaming-cream-vichy-125ml-100873890-p411718.html?spid=6970345',
'3337875542463_PYE*https://tiki.vn/tinh-chat-duong-da-trang-hong-cang-mong-vichy-idealia-lumiere-essence-m9150200-100867069-30ml-p653826.html?spid=6968999',
'3337875545884_PYE*https://tiki.vn/kem-duong-da-trang-hong-cang-mong-dung-cho-ban-ngay-vichy-idealia-lumiere-cream-m9157700-100867361-50ml-p653828.html?spid=6968995',
'3337871328610_PYE*https://tiki.vn/dung-dich-duong-trang-da-giam-tham-nam-tu-sau-ben-trong-vichy-ideal-white-meta-whitening-emulsion-m8621800-50ml-p438343.html?spid=6968993',
'3337875474450_PYE*https://tiki.vn/kem-duong-trang-da-ban-dem-mat-na-ngu-vichy-ideal-white-sleeping-mask-100854588-75ml-p638566.html?spid=6965811',
'3337871329402_PYE*https://tiki.vn/sua-rua-mat-tao-bot-duong-trang-da-vichy-ideal-white-brightening-deep-cleansing-foam-100703019-m9440600-100ml-p433601.html?spid=6965809',
'3337871328634_PYE*https://tiki.vn/tinh-chat-duong-trang-sau-7-tac-dung-vichy-ideal-white-meta-whitening-essence-100854585-30ml-p438347.html?spid=6965807',
'3337871323332_PYE*https://tiki.vn/kem-duong-chong-nep-nhan-va-nang-mi-mat-liftactiv-ds-eye-cream-vichy-15ml-100498225-p411663.html?spid=6965013',
'3337871331443_PYE*https://tiki.vn/nuoc-hoa-hong-lam-san-da-loai-bo-doc-to-vichy-aqualia-thermal-hydrating-refreshing-water-200ml-100749928-p449518.html?spid=6965011',
'3337871325442_PYE*https://tiki.vn/mat-na-ngu-cung-cap-nuoc-tuc-thi-vichy-aqualia-masque-nuit-100690954-15ml-p422220.html?spid=6965009',
'3337871324568_PYE*https://tiki.vn/mat-na-ngu-cung-cap-nuoc-tuc-thi-aqualia-masque-nuit-vichy-100888918-75ml-p411964.html?spid=6965007',
'3337875588775_PYE*https://tiki.vn/gel-duong-am-giup-da-diu-mat-cho-da-thuong-da-hon-hop-da-nhay-cam-vichy-aqualia-thermal-rehydrating-gel-cream-50ml-mb066000-p5430001.html?spid=6964059',
'3337871330163_PYE*https://tiki.vn/kem-duong-am-cho-mat-vichy-aqualia-thermal-awakening-eye-balm-dynamic-hydration-100703234-15ml-p433597.html?spid=6964057',
'3337875588713_PYE*https://tiki.vn/tinh-chat-duong-am-cho-moi-lan-da-vichy-aqualia-thermal-rehydrating-serum-30ml-mb065100-p5429997.html?spid=6964055',
'3337875588829_PYE*https://tiki.vn/kem-gel-duong-am-kich-hoat-giu-nuoc-cho-da-thuong-da-kho-vichy-aqualia-thermal-rehydrating-light-cream-50ml-mb067200-p5429999.html?spid=6963553',
'3337871308612_PYE*https://tiki.vn/nuoc-xit-khoang-duong-da-vichy-150ml-100829485-p411327.html?spid=6962731',
'3337871321963_PYE*https://tiki.vn/nuoc-xit-khoang-duong-da-vichy-100843334-300ml-p411324.html?spid=6962729',
'3337875508933_PYE*https://tiki.vn/mat-na-duong-da-bun-khoang-se-khit-lo-chan-long-vichy-pore-purifying-clay-mask-75ml-m9105000-p599091.html?spid=6962517',
'3337871322533_PYE*https://tiki.vn/sua-rua-mat-tay-trang-3-tac-dung-purete-thermale-one-step-cleanser-3-in-1-vichy-100ml-100429995-p411941.html?spid=6962451',
'3337875508919_PYE*https://tiki.vn/mat-na-khoang-chat-lam-diu-da-vichy-quenching-mineral-mask-75ml-m9104500-p599081.html?spid=6962447',
'3337871330125_PYE*https://tiki.vn/gel-rua-mat-giai-doc-to-va-ngan-ngua-o-nhiem-vichy-purete-thermal-fresh-cleansing-gel-200ml-m0355800-100746193-p447782.html?spid=6962445',
'3337871320980_PYE*https://tiki.vn/sua-rua-mat-tao-bot-dang-mut-chong-o-nhiem-cho-da-thuong-da-hon-hop-va-da-nhay-cam-vichy-m5038902-150ml-p439635.html?spid=6962091',
'3337871330347_PYE*https://tiki.vn/sua-rua-mat-tao-bot-dang-kem-vichy-purete-thermale-hydrating-and-cleansing-foaming-cream-100703235-125ml-p433572.html?spid=6962089',
'3337871319144_PYE*https://tiki.vn/sua-rua-mat-tay-trang-3-tac-dung-purete-thermale-one-step-cleanser-3-in-1-vichy-200ml-100703307-p415517.html?spid=6962085',
'3337871323295_PYE*https://tiki.vn/sua-rua-mat-tao-bot-dang-mut-chong-o-nhiem-cho-da-thuong-da-hon-hop-va-da-nhay-cam-vichy-m3408400-50ml-p439620.html?spid=6962083',
]

if __name__ == '__main__':
    pool = Pool(processes=4)
    outputs = pool.map(getImage,urls)
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