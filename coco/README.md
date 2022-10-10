# coco密钥解析

## 原理
自动下载使图片解密的JavaScript文件，用[Babel](https://github.com/babel/babel)解析解密函数中的密钥
> 目标网站添加了`CloudFlare IUAM`防护，本项目使用[自动化工具](/lib/)尝试绕过，可查看[coco.sh](/coco/coco.sh)安装相关依赖
## 安装依赖
> 默认使用puppeteer，需要安装Nodejs
```bash
npm install
```
> 使用selenium cloudscraper，需要安装Python
```bash
pip install -r requirements.txt
```
## 使用
```bash
source ~/autoCI/coco/coco.sh
main
```
## 相关项目
* https://github.com/Tsaiboss/decodeObfuscator
* https://github.com/Xwite/decodeObfuscator
