#!/usr/bin/env python

import undetected_chromedriver as uc
from time import sleep
import re, sys
from selenium.webdriver.common.by import By

def saveContent(url, savePath):
    driver = uc.Chrome(headless=True,use_subprocess=False)
    
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
