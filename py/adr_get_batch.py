from getImage import getImage,getlink,getPrice,gettotalpage,makemydir
from multiprocessing import Pool
import urllib.request

filename = 'thienanh.csv'
downloadfolder = 'adr'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder
url =  'https://www.adayroi.com/THIEN-ANH-mc2137'
f = open(filename, "w", encoding="utf-8")
f.write("")
if __name__ == '__main__':
	totalpage = int(gettotalpage(url))
	items =[]
	for i in range(1,int(totalpage)+1):
		print('Page '+str(i-1))
		urlpage = url +'?page='+str(i-1)
		print(urlpage)
		items = items + getlink(urlpage)
	pool = Pool(processes=8)
	outputs = pool.map(getImage,items)
	pool.close()
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