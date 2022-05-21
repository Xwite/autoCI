#!/usr/bin/env bash

# 下载js
python3 ./lib/selenium_fetch.py "https://www.cocomanga.com/js/custom.js" "coco.js"

# 解析密钥
node ./decodeObfuscator/main.js ./coco.js common cocomanhua
