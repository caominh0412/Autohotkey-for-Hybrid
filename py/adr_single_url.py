from getImage import getImage,getlink,getPrice,gettotalpage,makemydir
from multiprocessing import Pool
import urllib.request


urls = [
'BDGMXS01*https://www.adayroi.com/bo-dau-goi-va-dau-xa-tai-tao-chuyen-sau-maxcare-argan-oil-revitalizing-520ml-p-PRI1041240'
'STKSCBV01*https://www.adayroi.com/sap-tao-kieu-sieu-cung-beaver-magotan-matt-hard-wax-75g-p-PRI1062956'
'MNPHBV7*https://www.adayroi.com/mat-na-toc-phuc-hoi-chuyen-sau-beaver-intensive-remedy-treatment-mask-total-7-500ml-p-PRI991828'
'MNTBVDMA01*https://www.adayroi.com/mat-na-bun-phuc-hoi-toc-aurane-sea-mud-ultra-repairing-hair-mask-500g-p-PRI991867'
'GTKBVS5*https://www.adayroi.com/xit-tao-kieu-toc-cung-beaver-magotan-5-firm-hold-finishing-spray-250ml-p-PRI1063874'
'DGTDOLAR01*https://www.adayroi.com/dau-goi-kiem-soat-dau-aurane-olives-oil-control-shampoo-750ml-p-PRI1063499'
'DGTTMX01*https://www.adayroi.com/dau-goi-tai-tao-chuyen-sau-maxcare-argan-oil-revitalizing-shampoo-800ml-p-PRI1041157'
'BCXDGAR01*https://www.adayroi.com/bo-dau-goi-xa-phuc-hoi-aurane-750ml-chai-p-PRI1022144'
'MNTTTHA01*https://www.adayroi.com/mat-na-tai-tao-toc-aurane-nutri-care-restructuring-mask-1000ml-p-PRI991902'
'DGCRBVS6*https://www.airehon.com/dau-goi-chong-rung-va-kich-thich-moc-toc-beaver-hydro-scalp-energizing-shampoo-6-258ml.html'
'TDARAG*https://www.adayroi.com/tinh-dau-duong-toc-argan-soft-liss-125ml-p-PRI1101971'
'BDGTDBVC8*https://www.adayroi.com/bo-dau-goi-cho-toc-dau-va-dau-xa-tai-tao-toc-beaver-hydro-p-PRI1040931'
'DBTC*https://www.adayroi.com/dau-duong-bong-toc-tinh-chat-argan-maxcare-morocco-color-protect-silky-oil-100ml-p-PRI1062454'
'BCXDGAR02*https://www.adayroi.com/bo-dau-goi-xa-phuc-hoi-aurane-250ml-chai-p-PRI1022163'
'BDGTGOLAR*https://www.adayroi.com/bo-doi-dau-goi-tri-gau-va-dau-xa-dinh-duong-aurane-p-PRI1063537'
'DXBX0132*https://www.adayroi.com/dau-xa-sieu-duong-beaver-nutritive-repairing-conditioner-3-210ml-p-PRI946752'
'BDGCRBVC6*https://www.adayroi.com/bo-dau-goi-kich-thich-moc-toc-va-dau-xa-tai-tao-beaver-hydro-p-PRI1041027'
'DXAR02*https://www.adayroi.com/dau-xa-dinh-duong-aurane-balancing-conditioner-250ml-p-PRI946465'
'XCRVKTBV01*https://www.adayroi.com/xit-duong-da-dau-chong-rung-toc-beaver-hydro-scalp-energizing-essense-spray-6-50ml-p-PRI992381'
'DHTTBVAG*https://www.adayroi.com/mat-na-duong-am-phuc-hoi-toc-beaver-argan-oil-moisture-repair-mask-250ml-p-PRI1062804'
'DGAR01*https://www.adayroi.com/dau-goi-phuc-hoi-aurane-protein-moisturizing-shampoo-250ml-p-PRI946390'
'DXAR01*https://www.adayroi.com/dau-xa-dinh-duong-aurane-balancing-conditioner-750ml-p-PRI946446'
'DGAR02*https://www.adayroi.com/dau-goi-phuc-hoi-aurane-protein-moisturizing-shampoo-250ml-p-PRI946390'
'GTTCNTBV*https://www.adayroi.com/gel-tao-kieu-beaver-firm-hold-gel-nutri-sculpt-150g-p-PRI1062878'
'BDGARTDOL*https://www.adayroi.com/bo-doi-dau-goi-kiem-soat-dau-va-dau-xa-dinh-duong-aurane-p-PRI1063535'
'XKBVSD01*https://www.adayroi.com/xa-kho-sieu-duong-beaver-hydro-nutritive-rich-moisturizer-3-200ml-p-PRI1048807'
'DGBX013*https://www.adayroi.com/dau-xa-sieu-duong-beaver-nutritive-repairing-conditioner-3-768ml-p-PRI946758'
'DBBVAR50*https://www.adayroi.com/tinh-dau-duong-bong-toc-dau-argan-beaver-argan-oil-hair-serum-50ml-p-PRI1048660'
'DGCDBVS4*https://www.adayroi.com/dau-goi-tri-gau-chong-rung-toc-beaver-hydro-scalp-purifying-shampoo-4-258ml-p-PRI1040779'
'GDX3DA01*https://www.adayroi.com/gel-duong-tao-kieu-toc-xoan-aurane-elastin-with-moisturizing-325ml-p-PRI990348'
'MNPHOP01BV*https://www.adayroi.com/mat-na-duong-toc-phuc-hoi-beaver-1-minute-acidic-milky-hair-mask-210ml-p-PRI1063350'
'STKMAR01*https://www.adayroi.com/sap-tao-kieu-mo-aurane-cool-stylish-clay-80ml-p-PRI992034'
]

global filename
global downloadfolder
global folder
filename = 'image.csv'
downloadfolder = 'xuan_gap'
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