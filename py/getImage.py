from requests_html import HTMLSession
from multiprocessing import Pool 

session = HTMLSession()

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
		print(' Image : ' + image_link)
	print(SKU)
	return item
urls = ['https://www.adayroi.com/balo-nu-carlo-rino-0303717-001-13-mau-xanh-duong-p-799244?offer=799244_O4X',

'https://www.adayroi.com/tui-deo-cheo-carlo-rino-0304166-001-28-mau-xam-p-767204?offer=767204_O4X',

'https://www.adayroi.com/tui-deo-cheo-carlo-rino-0304166-001-13-mau-xanh-coban-p-774031?offer=774031_O4X',

'https://www.adayroi.com/balo-nu-venuco-madrid-d03s345-mau-trang-phoi-hoa-vang-p-375173?offer=375173_RAN',

'https://www.adayroi.com/tui-fbr-quai-dai-venuco-madrid-f02-mau-vang-nhat-p-582321?offer=582321_RAN',

'https://www.adayroi.com/tui-deo-cheo-nu-venuco-madrid-z04s364-mau-tim-nhat-p-374194?offer=374194_RAN',

'https://www.adayroi.com/balo-nu-venuco-madrid-g01f04-hoa-tiet-mau-xanh-la-p-377186?offer=377186_RAN',

'https://www.adayroi.com/balo-nu-carlo-rino-0303717-001-31-mau-be-p-797292?offer=797292_O4X',

'https://www.adayroi.com/balo-nu-venuco-madrid-d03s345-mau-xanh-da-troi-p-374231?offer=374231_RAN',

'https://www.adayroi.com/tui-xach-nu-carlo-rino-0304132a-001-08-den-p-799809?offer=799809_O4X',

'https://www.adayroi.com/tui-bucket-mini-venuco-madrid-s364-xanh-la-p-580386?offer=580386_RAN',

]

if __name__ == '__main__':
	pool = Pool(processes=4)
	output = pool.map(getImage,urls)
	pool.close()
	pool.join()
	print(output)
#urls = ['https://www.adayroi.com/tui-bucket-mini-venuco-madrid-s364-xanh-la-p-580386?offer=580386_RAN']
#filename = 'image.csv'
#f = open(filename, "w", encoding="utf-8")
#f.write("")
#for url in urls:
#	a = getImage(url)
#	print('SKU : '+ a['SKU'])
#	f.write(a['SKU'])
#	for i in range(0,len(a)-1):
#		f.write('*'+a['image'+str(i)])
#		print(' Image: '+a['image'+str(i)])
#	f.write('\n')
#f.close()
print('DONE')
