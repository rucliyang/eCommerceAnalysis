'''
This code is used for text preprocessing. 
Before doing that, we need to put all reviews line by line in a single file.
Two external files (stopwords.txt, punctuation.txt) are also needed to remove Chinese stopwords and messy characters.
'''

import sys
reload(sys)
sys.setdefaultencoding('utf8')
import nltk


#to remove numbers, single alphabets and English stopwords
from nltk.corpus import stopwords
Eng_stop=stopwords.words('english')
deldig=['0','1','2','3','4','5','6','7','8','9']
alphabet=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
Alphabet=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
stops=Eng_stop+alphabet+Alphabet+deldig

#to remove Chinese stopwords, we need load another file
c=open(".\\data\\stopwords.txt")
stop=[0]*1
for line in c:
    if(line[-1]=='\n'):
        line=line[:-1]
    line=line.decode('utf-8')
    stop[-1]=line
    stop.append(0)

stop=stop[:-1]
c.close()
stops=stops+stop
stops=list(set(stops)) 

space=[u'\u0020',u'\u3000',u'\ufeff']
stops=stops+space


#to remove some messy characters often appeared in web contents
d=open(".\\data\\punctuation.txt")
punc=[0]*1
for line in d:
    if(line[-1]=='\n'):
        line=line[:-1]
    line=line.decode('utf-8')
    punc[-1]=line
    punc.append(0)

punc=punc[:-1]
d.close()
punc=list(set(punc))
punc=punc[1:]


#preprocess testdata
f=open('.\\data\\testdata.txt')
s=open('.\\data\\data_after_pre.txt',"a+")
for line in f:
    line=line.decode('utf-8')
    for aa in stops:
        line=line.replace(aa,'')
    for cc in punc:
        if(cc in line):
            line=line.replace(cc,'.')
    line=line.replace(' ','')
    line=line.replace('..','.')
    s.write(line)

f.close()
s.close()
