import bs4
import requests
from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup

filename = 'quangcao.doc'
f = open(filename, "w", encoding="utf-8")
f.write("")
urlcha = 'http://xacnhanquangcao.vfa.gov.vn/tra-cuu?p_p_id=tracuuvesinhantoanthucpham_WAR_moh_cchc_2013portlet&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_tracuuvesinhantoanthucpham_WAR_moh_cchc_2013portlet_jspPage=%2Fhtml%2Fvsattp%2Fsearch_list.jsp&_tracuuvesinhantoanthucpham_WAR_moh_cchc_2013portlet_delta=5&_tracuuvesinhantoanthucpham_WAR_moh_cchc_2013portlet_keywords=&_tracuuvesinhantoanthucpham_WAR_moh_cchc_2013portlet_advancedSearch=false&_tracuuvesinhantoanthucpham_WAR_moh_cchc_2013portlet_andOperator=true&_tracuuvesinhantoanthucpham_WAR_moh_cchc_2013portlet_resetCur=false&_tracuuvesinhantoanthucpham_WAR_moh_cchc_2013portlet_cur='
for i in range(1,1807):
    my_url = urlcha + str(i)
    print(my_url)
    print('Page:' + str(i))
    uClient = uReq(my_url)
    page_html = uClient.read()
    uClient.close()
    page_soup = soup(page_html,"html.parser")
    row = page_soup.findAll('tr',{'class':'le'})
    for i in range(0,len(row)):
        #f.write(row[i])
        f.write(str(row[i]))
        f.write("\n")
f.close()