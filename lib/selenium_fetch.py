#!/usr/bin/env python

import undetected_chromedriver as uc
from time import sleep
from subprocess import getoutput
import re, sys
from selenium import webdriver
from selenium.webdriver.common.by import By

def saveContent(url, savePath):
    # 获取chrome的主要版本号
    version_str = getoutput('google-chrome --version')
    #version_str="google chrome 100.0.13.77"
    version_match = re.match( r'.*?(\d+).*', version_str)
    global version_main
    version_main = 99
    try:
        version_main = int(version_match.group(1))
        print(f"chrome main version: {version_main}")
    except:
        print("fail to get chrome version ")
    
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    driver = uc.Chrome(options=options, version_main=version_main)
    
    print(f"start download {url}...")
    try:
        driver.get(url)
        sleep(10)
        print(driver.page_source[0:200])
        
        content = driver.find_element(by=By.CSS_SELECTOR, value="body").text
        f = open(savePath, "w")
        f.write(content)
        print(f"save to {savePath} successfully")
        f.close()

        driver.close()
        driver.quit()
    except:
        print("fail to get content")

if __name__ == '__main__':
    argv = sys.argv[1:]
    if len(argv) != 2:
        print('ERROR: 参数错误,请以这种格式重新尝试\npython selenium.py url savePath')
    url = argv[0]
    savePath= argv[1]
    saveContent(url, savePath)
