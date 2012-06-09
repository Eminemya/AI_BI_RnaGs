    for N in [150,200]:
        for u in range(1,4):
            #subprocess.call(["kinit" \"ZHUzhu890423"\""], shell=True)
            #print 'haha'
            process=subprocess.Popen(["ssh -t "+names[iii]+" \"python /home/dtwei/Desktop/python2/tt.py "+str(N)+" "+str(zz)+" "+str(u) + "\""], shell=True)
            process.poll()
            iii+=1
