from getImage import getImage,getlink,getPrice,gettotalpage,makemydir
from multiprocessing import Pool
import urllib.request


urls = [
"http://adayroi.com/p/1348413",
"http://adayroi.com/p/1929023",
"http://adayroi.com/p/1929026",
"http://adayroi.com/p/1929027",
"http://adayroi.com/p/1929028",
"http://adayroi.com/p/1929029",
"http://adayroi.com/p/1929030",
"http://adayroi.com/p/1929031",
"http://adayroi.com/p/1929032",
"http://adayroi.com/p/1929033",
"http://adayroi.com/p/1929034",
"http://adayroi.com/p/1929035",
"http://adayroi.com/p/1929036",
]

global filename
global downloadfolder
global folder
filename = 'image.csv'
downloadfolder = 'thuyttt_8'
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