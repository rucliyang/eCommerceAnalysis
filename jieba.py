import sys
import jieba

if __name__ == '__main__':
    #sys.path.append("../")

    print "Loading user dict."
    jieba.load_userdict(".\\userdict.txt")

    print "Loading candidate content."
    infile = open(".\\testdata.txt",'r')
    candidate_line = infile.read()
    infile.close()

    print "Segmentation started."
    seg_list = jieba.cut(candidate_line, cut_all=False)
    wholestr = ' '.join(seg_list)
    wholestr=wholestr.replace(" . "," ")
    wholestr=wholestr.replace(u" \n ",u'\n')

    print "Segmentation finished, writing into txt file."
    outfile = open(".\\data_seg.txt",'a')
    outfile.write(wholestr.encode('utf-8'))
    outfile.close()
    print "Totally finished."