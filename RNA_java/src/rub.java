import java.io.*;
import java.util.Arrays;

public class rub {
	BufferedReader in;
	PrintWriter out_pu;
	public void C_aln(String to, String aln) throws IOException{
		
		int t,tmp,sum1=0,sum2=0;
		
		
		out_pu = new PrintWriter(to);
		out_pu.println("CLUSTAL 2.0.12 multiple sequence alignment");
		out_pu.println();
		out_pu.println();
		
		String[] alins=aln.split(",");
	//System.out.println(aln);
		
		
for (t=0;t<alins.length/2;t++){
	tmp=count(alins[2*t]);
	sum1=sum1+tmp;
	String[] tmp1=alins[2*t].split(" ");
	int i,len=tmp1[0].length();
	for(i=0;i<30-len;i++){
		tmp1[0]=tmp1[0]+" ";
	}
	out_pu.println(tmp1[0]+tmp1[tmp1.length-1]+" "+sum1);
	tmp=count(alins[2*t+1]);
	sum2=sum2+tmp;
	String[] tmp2=alins[2*t+1].split(" ");
	len=tmp2[0].length();
	for(i=0;i<30-len;i++){
		tmp2[0]=tmp2[0]+" ";
	}
	out_pu.println(tmp2[0]+tmp2[tmp2.length-1]+" "+sum2);
	out_pu.println(find_star(tmp1[tmp1.length-1],tmp2[tmp2.length-1]));
	out_pu.println();
	
	//System.out.println(alins[2*t]);
	//System.out.println(alins[2*t+1]);
}
		//out_pu.println();
		
		out_pu.close();
	}	
	
	public String find_star(String seq1,String seq2){
		
		StringBuffer result=new StringBuffer();
		result.append("                              ");
		//System.out.println(arr1[0]+"hoho"+arr2.length);
		int i;
		
		for (i=0;i<seq1.length();i++){
		//	System.out.println((int)seq1.charAt(i)+"hoho"+(int)seq2.charAt(i));
			if((int)seq1.charAt(i)==(int)seq2.charAt(i)){
					
				result.append("*");
			}else{
				result=result.append(" ");
			}
		}
	//	System.out.println(result+"hoho");
		return result.substring(0);
	}
	public int count(String aln){
		int count=0,i;
		String[] arr=aln.split(" ");
		String seq=arr[arr.length-1].trim();
		
		for(i=0;i<seq.length();i++){
		if(seq.charAt(i)=="-".charAt(0)){
			count=count+1;
		}
		}
		//System.out.println(count);
		return seq.length()-count;
	}
	public String[] C_sto(String from, String to, String stru) throws IOException{
		String reader=new String();
		int i,t,tmp=0,len,stu_tmp;
		
		in = new BufferedReader(new FileReader(from));
		
		out_pu = new PrintWriter(to);
		String[] seq=new String[2];
		StringBuffer seq1=new StringBuffer();
		StringBuffer seq2=new StringBuffer();
		
		out_pu.println("# STOCKHOLM 1.0");
		out_pu.println(" ");
		in.readLine();
		reader=in.readLine();
		while(reader.trim().length()==0){
		reader=in.readLine().trim();
		}
		
		String[] strus=chop_seq(stru);
		
	    stu_tmp=0;
		while(reader!=null && reader.trim().length()!=0){
	//		System.out.println(reader.trim().length());
	    int bl2;
	    bl2=reader.lastIndexOf(" ");
	    for (t=0;t<2;t++){
		String haa=reader.substring(0,bl2);
		if(t==0){
	    //System.out.println(reader.substring(30,bl2));
		seq1.append(reader.substring(30,bl2));
		}else{
	    seq2.append(reader.substring(30,bl2));	
		}
		//System.out.println(haa);
		out_pu.println(haa);
		reader=in.readLine();
		}
		//System.out.println("hoho"+stu_tmp);
		out_pu.println("#=GC SS_cons                  "+strus[stu_tmp]);
		out_pu.println();
		stu_tmp=stu_tmp+1;
		reader=in.readLine();
		reader=in.readLine();
		//System.out.println(reader);
		//System.out.println(reader+"haha"+t);
		}
		out_pu.println("//");
		out_pu.close();
		
		seq[0]=seq1.substring(0);
		seq[1]=seq1.substring(0);
		return seq;
	}
public String P_matlab(String from) throws IOException{
		
		String reader;
		StringBuffer stru = new StringBuffer();	
		in = new BufferedReader(new FileReader(from));
		reader=in.readLine();
		String[] seq1=chop_seq(reader);
		reader=in.readLine();
		String[] seq2=chop_seq(reader);
		int i,j,tmp,len=(int)reader.length()/50;
		tmp=len;
		if(len*50<reader.length()){
			tmp=len+1;
		}	
		
		for(j=0;j<tmp;j++){ 
		stru.append("seq1");
		
		for(i=0;i<26;i++){
			stru.append(" ");	
		}
		stru.append(seq1[j]).append(",");
		stru.append("seq2");
		for(i=0;i<26;i++){
			stru.append(" ");	
		}
		stru.append(seq2[j]).append(",");
		
		}	
		System.out.println(stru);
		return stru.substring(0);
	}

public String[] chop_seq(String seq){
	
	int i,tmp,len=(int)seq.length()/50;
	tmp=len;
	if(len*50<seq.length()){
		tmp=len+1;
	}
	
	String[] strus=new String[tmp];
	//System.out.println(len+","+tmp+","+strus.length);
	for(i=0;i<len;i++){
		strus[i]=seq.substring(i*50,(i+1)*50);
		//System.out.println(strus[i]);
	}
	if(len*50<seq.length()){
		strus[tmp-1]=seq.substring((tmp-1)*50);
		//System.out.println(strus[tmp-1]);
	}

	return strus;
}
}