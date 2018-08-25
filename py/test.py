from getImage import getImage,getlink,getPrice,gettotalpage,makemydir
from multiprocessing import Pool
import urllib.request

filename = 'image.csv'
downloadfolder = 'test'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder
url =  'https://www.adayroi.com/oppo-br4939'

if __name__ == '__main__':
	totalpage = int(gettotalpage(url))
	for i in range(1,int(totalpage)):
		print('Page '+str(i-1))
		urlpage = url +'?page='+str(i-1)
		print(urlpage)
		items = getlink(urlpage)
		pool = Pool(processes=4)
		outputs = pool.map(getImage,items)
		pool.close()
		pool.join()
		pool.close()
		f = open(filename, "w", encoding="utf-8")
		f.write("")
		for item in outputs:
			print('SKU: '+ item['SKU'])
			f.write(item['SKU'])
			
			#print(imgdownload)
			makemydir(folder+'/'+item['SKU'])
			for i in range(0,len(item)-1):
				f.write('*'+item['image'+str(i)])
				print(' Image: '+item['image'+str(i)])
				imgdownload = folder+'/'+item['SKU']+'/'+item['SKU']+'_'+str(i+1)+'.jpg'
				urllib.request.urlretrieve(item['image'+str(i)],imgdownload)
			f.write('\n')
		print('DONE')
