from getImage import getImage,getlink,getPrice,gettotalpage,makemydir
from multiprocessing import Pool
import urllib.request


urls = [
'https://www.adayroi.com/vali-keo-tre-em-welly-batmobile-91007w-den-p-PRI1016694'

]

global filename
global downloadfolder
global folder
filename = 'image.csv'
downloadfolder = 'thay anh'
folder = 'C:/Users/minhcq/Desktop/download/'+downloadfolder

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