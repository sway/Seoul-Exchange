import sys
import datetime
from pytz import timezone
from lxml import etree

kst = timezone("Asia/Seoul")

def processPost(post):
	title = post.findtext("title").encode('utf8')
	dateStr = post.findtext("pubDate")
	dateStr = dateStr[:-6]
	
	dt_gmt = datetime.datetime.strptime(dateStr, "%a, %d %b %Y %H:%M:%S")
	dt_gmt = dt_gmt.replace(tzinfo=timezone("GMT"))

	dt = dt_gmt.astimezone(kst)
	
	filename = dt.strftime("%Y-%m-%d-%H-%M-%S") + '.tex'
	
	content = post.findtext("content_encoded")	
	
	f = open("data/" + filename, "w")
	
	f.write('\\begin{post}\n')
	f.write('\t\\posttitle{' + title + '}\n')
	f.write('\t\\postdate{' + str(dt.year) + '}{' + str(dt.month) + '}{' + str(dt.day) + '}{' + str(dt.hour) + '}{' + str(dt.minute) + '}{' + str(dt.second) + '}\n')
	
	f.close()
	
if len(sys.argv) < 2:
	sys.exit("You have to supply the filename!")

file = sys.argv[1]

blog = etree.parse(file)

for post in blog.getiterator("item"):
	processPost(post)


