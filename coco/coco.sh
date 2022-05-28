#!/usr/bin/env bash

url="https://www.cocomanga.com/js/custom.js"
savePath="coco.js"
ua_string="user-agent:Mozilla/5.0 (Linux; Android 11;Pixel XL) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/100.0.4896.79 Mobile Safari/537.36"

use_cloudscraper=true
use_selenium=true
use_puppeteer=true

# 解密工具
[ -e decodeObfuscator ] || git clone https://github.com/Xwite/decodeObfuscator --depth 1

function extraKeys() {
    node ./decodeObfuscator/main.js $savePath common cocomanhua
}

function checkDown() {
   if [ -e $savePath ]; then
       [ -z $(cat $savePath | grep "<html") ] && return 0
   else
       return 1
   fi
}

function cloudscraper() {
    pip install cloudscraper
    python3 ./lib/cloudscraper_fetch.py $url $savePath
    if checkDown;then
        extraKeys
        return 0
    else
       echo -e "\033[41;30m ERROR \033[40;31m cloudscraper fetch content error"
       return 1
    fi
}

function selenium() {
    pip install undetected-chromedriver
    python3 ./lib/selenium_fetch.py $url $savePath
    if checkDown;then
        extraKeys
        return 0
    else
       echo -e "\033[41;30m ERROR \033[40;31m selenium fetch content error"
       return 1
    fi
}

function puppeteer() {
    npm install puppeteer puppeteer-extra puppeteer-extra-plugin-stealth
    node ./lib/puppeteer_fetch.js $url $savePath
    if checkDown;then
        extraKeys
        return 0
    else
       echo -e "\033[41;30m ERROR \033[40;31m puppeteer fetch content error"
       return 1
    fi
}

echo -e "\033[42;30m INFO \033[40;32m fetch $url"
statusCode=$(curl -s -I -H "$ua_string" -w %{http_code} "$url" -o /dev/null)
#statusCode=504
if [ $statusCode == "200" ];then
    curl -s -H "$ua_string" "$url" -o "$savePath"
else
    echo -e "\033[42;30m INFO \033[40;32m http code is $statusCode try bypass tool"
fi

if checkDown;then
    extraKeys
else
    $use_cloudscraper && cloudscraper && exit
    $use_selenium && selenium && exit
    $use_puppeteer && puppeteer && exit
fi