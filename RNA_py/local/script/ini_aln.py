def ini_aln(infile):
    a=open(infile)
    b=open('00aln','w')
    b.write('>alignment 0\n')
    line=a.readline()
    line=a.readline()
    while line:
        if line[0]!='>':
            b.write(line[:-1])
        else:
            b.write('\n')        
        line=a.readline()
    b.write('\n')
    a.close()
    b.close()    
