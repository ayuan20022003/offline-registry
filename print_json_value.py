#!/usr/bin/env python
import json


filepath="/data/offlinesry/imagelist.txt"

list = {}
with open(filepath) as f: 
	data = f.read() 
	list = json.loads(data)

for v in list.values():
	print v
