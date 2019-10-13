# coding: utf-8

import requests
import os,sys
session = requests.Session()
session.headers = {
	'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'
}
for i in range(1,100):
	session.get('https://meiriyiwen.com')
	pic = session.get('https://meiriyiwen.com/images/new_feed/bg_'+str(i)+'.jpg')

	with open(os.path.dirname(os.path.realpath(__file__))+'\\bg_'+str(i)+'.jpg', 'wb') as f:
		f.write(pic.content)