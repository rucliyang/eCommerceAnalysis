#########################
1.Data description

Below, we introduce each data file contained in the "data" folder.

(1)English comments.txt
This file contains 3000 original English comments as examples.
spuId：the index of each phone
orderId：the index of each comment
commentStars：score
content：the textual content of comments
country：the country of the user
userNickName：the user's nickname

(2)Chinese comments.txt
This file contains 3000 original Chinese comments as examples.
spuId：the index of each phone
orderId：the index of each comment
commentStars：score
content：the textual content of comments
brand: the brand of phones	
country：the country of the user
userNickName：the user's nickname
tbrandDetails: the product details
userClient: the client of phones
userLevel: the level of users

(3)testdata.txt; only comments (English).txt
This file contains the comments only, which are used for illustration of text preprocessing.

(4)stopwords.txt and punctations.txt
The two files are used to remove Chinese stopwords and punctions, which are called by preprocessing.py

(5)userdict.txt
The jieba word segmentation algorithm is based on its build-in dictionary. However, this dictionary is just a basic one and cannot include every word. To solve this problem, it's better for us to add more words used in commenting phones. We contain these words in the file "userdict.txt"
This file is called by jieba.py

(6)data_ttest.csv
This file contains topic probabilities for the sample reviews in "English comments.txt" and "Chinese comments.txt".
This file is used for illustration of applying t.test.

(7)phone_infor.csv
This file contains phone related features, and their corresponding topic probabilities for 100 phones.
Note that, the ``Rating" variable is just the ``Rating score" for each cellphone.
This file is used for illustration of building regression and conducting variable selection.




#########################
2. Codes for data crawler
The folder "crawler" contains all parsing codes
Note that，we need to first list the urls used to crawl the data. For example, the file ``JD_Samsung.txt" used in ``JD_Crawler_comms.py" contains all the urls corresponding to the Samsung cellphones.


#########################
3. Codes for data preprocessing

(1)preprocess.py
This code is used for text preprocessing, e.g. removing numbers, punctations and stopwords

(2)jieba.py
This file is used for Chinese word segmentation. 


#########################
4. Codes for building models

(1)the "lda" folder.
This forlder contains codes for a C/C++ implementation of LDA (Blei et al., 2003).
It's downloaded from a public source, i.e., "http://gibbslda.sourceforge.net/".
The needed environment and usage of these codes can be found in "readme.txt" in the lda folder.
More details can be found in the website "http://gibbslda.sourceforge.net/".


(2)the "btm" folder
This forlder contains codes for a C/C++ implementation of BTM (Yan et al.,2013).
It's downloaded from "https://code.google.com/archive/p/btm/downloads".
The needed environment and usage of these codes can be found in "readme.txt" in the btm folder.
More details can be found in the website "https://code.google.com/archive/p/btm/".



#########################
5. Codes for data analysis

(1)the "figure" folder
This forlder contains codes for drawing Figure 4, 5 and 6.

(2)ttest.R
This code is an R implementation of t test.

(3)regression.R
This code is for building regression models and conducting variable selection.