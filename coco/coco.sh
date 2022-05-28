#!/usr/bin/env bash

url="https://www.cocomanga.com/js/custom.js"
savePath="coco.js"
ua_string="user-agent:Mozilla/5.0 (Linux; Android 11;Pixel XL) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/100.0.4896.79 Mobile Safari/537.36"

function extraKeys() {
    # 解析密钥
    git clone https://github.com/Xwite/decodeObfuscator --depth 1
    node ./decodeObfuscator/main.js $savePath common cocomanhua
}

statusCode=$(curl -s -I -H "$ua_string" -w %{http_code} "$url" -o /dev/null)
if [ $statusCode == "200" ];then
    echo "INFO: response code $statusCode, download content"
    curl -s -H "$ua_string" "$url" -o "$savePath"
    extraKeys
else
    #use selenium download js
    echo "WARN: response code $statusCode, try selenium"
    pip install undetected-chromedriver
    python3 ./lib/selenium_fetch.py $url $savePath
    extraKeys
fi

