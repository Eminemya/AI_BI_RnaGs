import java.io.*;
import java.util.Arrays;

public class Parser {
	BufferedReader in;
	PrintWriter out_pu;
	public void C_aln(String to, String aln, int num_seq) throws IOException{
		
		int tmp_count;
		int[] sum=new int[num_seq];
for(int w=0;w<num_seq;w++){
sum[w]=0;
}
		out_pu = new PrintWriter(to);
		out_pu.println("CLUSTAL 2.0.12 multiple sequence alignment");
		out_pu.println();
		out_pu.println();
		String[] alins=aln.split(",");
	//System.out.println(aln);
				
for (int t=0;t<alins.length/num_seq;t++){

String[][] tmp =new String[num_seq][];
String[] star =new String[num_seq];
for(int ww=0;ww<num_seq;ww++){
	tmp_count=count(alins[num_seq*t+ww]);	
	sum[ww]=sum[ww]+tmp_count;
	tmp[ww]=alins[num_seq*t+ww].split(" ");
	int len=tmp[ww][0].length();
	for(int i=0;i<30-len;i++){
		tmp[ww][0]+=" ";
	}
	out_pu.println(tmp[ww][0]+tmp[ww][tmp[ww].length-1]+" "+sum[ww]);
	star[ww]=tmp[ww][tmp[ww].length-1];
}

	out_pu.println(find_star(star));
	out_pu.println();
	
	//System.out.println(alins[2*t]);
	//System.out.println(alins[2*t+1]);
}
		//out_pu.println();
        out_pu.flush();
		out_pu.close();
	}	
	
	public String find_star(String[] seq){
		
		StringBuffer result=new StringBuffer();
		result.append("                              ");
		//System.out.println(arr1[0]+"hoho"+arr2.length);
		int i;
		int check;		
		for (i=0;i<seq[0].length();i++){
		//	System.out.println((int)seq1.charAt(i)+"hoho"+(int)seq2.charAt(i));
			check=0;		
			//System.out.println(seq.length-1);
			//System.out.println(i);
		for(int ww=0;ww<seq.length-1;ww++){
		check+=	Math.pow(((int)seq[ww].charAt(i)-(int)seq[ww+1].charAt(i)),2);
			}
			if(check==0){	
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
		if(seq.charAt(i)=="-".charAt(0)||seq.charAt(i)==".".charAt(0)){
			count=count+1;
		}
		}
		//System.out.println(count);
		return seq.length()-count;
	}
	public String[] C_sto(String from, String to, String stru,int num_seq) throws IOException{
		String reader=new String();
		int t,stu_tmp;
		//System.out.println(stru);
		in = new BufferedReader(new FileReader(from));
		
		out_pu = new PrintWriter(to);
		
		//StringBuffer[] seq=new StringBuffer[num_seq];
		//for(int w=0;w<num_seq;w++){seq[w].append(1);}
		String[] seqq=new String[num_seq];
		for (t=0;t<num_seq;t++){
			seqq[t]="";
		}
		out_pu.println("# STOCKHOLM 1.0");
		out_pu.println(" ");
		in.readLine();
		reader=in.readLine();
		//System.out.println(1+" "+reader);
		while(reader.trim().length()==0){
		reader=in.readLine().trim();
		//		System.out.println(2+" "+reader);
		}
		
		String[] strus=chop_seq(stru);	
	    stu_tmp=0;
	    
		while(reader!=null && reader.charAt(0)!=' '){
			//System.out.println(reader.trim().length());
	    int bl2;
	    bl2=reader.lastIndexOf(' ');
	   // System.out.println(bl2);
	    for (t=0;t<num_seq;t++){
		String haa=reader.substring(0,bl2);
		//System.out.println(reader.substring(30,bl2));
		//seq[t].append(reader.substring(30,bl2));
		seqq[t]+=reader.substring(30,bl2);
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
		out_pu.flush();
		out_pu.close();
		//for(int w=0;w<num_seq;w++){seqq[w]=seq[w].substring(1);}
		
		return seqq;
	}
public String P_matlab(String from,int num_seq) throws IOException{
		
		String reader=new String();
		StringBuffer stru = new StringBuffer();	
		in = new BufferedReader(new FileReader(from));
		String[][] seq =new String[num_seq][];
		for (int w=0;w<num_seq;w++){
		reader=in.readLine();
		seq[w]=chop_seq(reader);
		}
		int i,j,tmp,len=(int)reader.length()/50;
		tmp=len;
		if(len*50<reader.length()){
			tmp=len+1;
		}	
		
		for(j=0;j<tmp;j++){ 
	for (int w=0;w<num_seq;w++){
		stru.append("seq"+(w+1));
		for(i=0;i<26;i++){
			stru.append(" ");	
		}
		stru.append(seq[w][j]).append(",");
		}
		
		}
		
			
		//System.out.println(stru);
		return stru.substring(0,stru.length()-1);
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
public void Rfam_seq(String from, int numseq) throws IOException{
	
	in = new BufferedReader(new FileReader(from));
	String reader;
	int i,j,tmp;
	int[] lens=new int[numseq];
	String[] seqs=new String[numseq];
	String[] seqs2=new String[numseq];
	in.readLine();
	seqs[0]=in.readLine();
	lens[0]=seqs[0].length();
	tmp=lens[0];
	System.out.println(seqs[0]);
	for(i=1;i<numseq;i++){
		in.readLine();
		seqs[i]=in.readLine();
		System.out.println(seqs[i]);
		lens[i]=seqs[i].length();
		if(tmp>lens[i]){
			tmp=lens[i];
		}
		//System.out.println(lens[i]);
	}
	//System.out.println(tmp);
	int tmp2;
	for(i=0;i<tmp;i++){
		tmp2=0;
		for(j=0;j<numseq;j++){
			if(seqs[j].substring(i,i+1).equals(".")){
				tmp2+=1;
			}
			}
		if(tmp2!=numseq){
			for(j=0;j<numseq;j++){
		    seqs2[j]+=seqs[j].substring(i,i+1);
		                         }
			}
	}
	
	out_pu= new PrintWriter((new FileWriter(from+"new", true)));
	for(j=0;j<numseq;j++){
    out_pu.println(seqs2[j]);
	}
	out_pu.flush();
	out_pu.close();
	
	return;
}
}