#!/usr/bin/env python
import json
import os

filepath=os.getenv('IMAGELIST_DIR', "../offlinesry/imagelist.txt")

list = {}
with open(filepath) as f: 
	data = f.read() 
	list = json.loads(data)

for v in list.values():
	print v
