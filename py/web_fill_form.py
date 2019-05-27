from splinter import Browser
from selenium import webdriver
from selenium.webdriver.common.keys import Keys

browser = Browser('chrome',**{'executable_path':r'C:\Users\minhcq\AppData\Roaming\chromedriver.exe'})
browser.visit('https://mc.adayroi.com/HybrisProduct/Edit/2437261/view')

if 'Log in' in browser.title:
	browser.fill('UserName','v.minhcq@sxhand.com')
	browser.fill('Password','Caominh1.')
	browser.check('Remember')
	browser.find_by_css('.btn').first.click()

