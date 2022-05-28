#!/usr/bin/env python

import cloudscraper, sys

def saveContent(url, savePath):
    scraper = cloudscraper.create_scraper()

    content = scraper.get(url).text
    print(content[0:200])
    
    f = open(savePath, "w")
    f.write(content)
    print(f"save to {savePath} successfully")
    f.close()

if __name__ == '__main__':
    argv = sys.argv[1:]
    if len(argv) != 2:
        print('ERROR: 参数错误,请以这种格式重新尝试\npython cloudscraper.py url savePath')
    url = argv[0]
    savePath = argv[1]
    saveContent(url, savePath)
