import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;


public class Test {
	BufferedReader in;
	PrintWriter out_pu;
	
	public void P_sto(String from, String to,int ww) throws IOException{
		String reader=new String();
		int t=0;
		in = new BufferedReader(new FileReader(from));
		
		out_pu =  new PrintWriter(new FileWriter(to, true));
		out_pu.append(ww+"\n");
		in.readLine();
		reader=in.readLine();
		while(!reader.contains("//")){
			
			
			if(reader.contains("#")){
				//int[] a=new int[3];
				//a[0]=reader.indexOf(".");
				//a[1]=reader.indexOf("(");
				//a[2]=reader.indexOf(")");
				//Arrays.sort(a);
				//t=a[0];
//				System.out.println(reader.substring(30));
				out_pu.append(reader.substring(30));	
			}
			reader=in.readLine();
			//System.out.println(reader);
			if(reader==null){
				break;
			}
		}
		out_pu.append("\n");
		out_pu.close();
	}
	public void P_aln(String from, String to, int ww) throws IOException{
		String reader=new String();
		String line=new String();
		//System.out.println(from+","+to);			
			//seq1
		in = new BufferedReader(new FileReader(from));
		out_pu =  new PrintWriter(new FileWriter(to, true));
		//out_pu = new PrintWriter(to);
		out_pu.append(ww+"\n");
		reader=in.readLine();
		reader=in.readLine();
		reader=in.readLine();
		reader=in.readLine();
		while(reader.trim().length()!=0){		
			if(reader.contains("*")){
				reader=in.readLine();
				reader=in.readLine();
			}
			if(reader==null){
				break;
			}
		int tmp=reader.lastIndexOf(" ");
		//System.out.println(tmp);
		if(tmp<30) {tmp=31;}
		String arr=reader.substring(30,tmp);
		//System.out.println(arr);
		out_pu.append(arr);
		reader=in.readLine();
		reader=in.readLine();
		}
		out_pu.append("\n");
		//out_pu.print("#");
		
		//seq2
		in = new BufferedReader(new FileReader(from));
		reader=in.readLine();
		reader=in.readLine();
		reader=in.readLine();
		reader=in.readLine();
		reader=in.readLine();
		while(reader.trim().length()!=0){		
			if(reader.contains("*")){
				reader=in.readLine();
				reader=in.readLine();
				reader=in.readLine();
			}
			if(reader==null){
				break;
			}
		int tmp=reader.lastIndexOf(" ");
		//System.out.println(tmp);
		if(tmp<30) {tmp=31;}
		String arr=reader.substring(30,tmp);
	//	System.out.println(arr);
		out_pu.append(arr);
		reader=in.readLine();
		
		}
		out_pu.append("\n");
		out_pu.close();
	}

	public void P_pss(String from, String to) throws IOException{
		String reader=new String();
		String line=new String();
		in = new BufferedReader(new FileReader(from));
		out_pu = new PrintWriter(to);
		reader=in.readLine();
		reader=in.readLine();
		while(!reader.contains("ori_struct_seq")){
			reader=in.readLine();
		}
		String[] arr=reader.split(" ");
		System.out.println(arr[0]+","+arr[1]);
		out_pu.print(arr[1]);	
			
		
		out_pu.close();
	}
	public void fiv2tw(String from) throws IOException{
		String[] name={"Cobalamin","gcvT", "glmS" , "purine" , "RFN" , "sbox", "THI" , "tRNA" , "U1","yybp-ykoY"};
		int i,j;
		String read;
		for(i=0;i<10;i++){
			in = new BufferedReader(new FileReader(from+name[i]+"/set_0/5seq_set0.fa"));
			out_pu = new PrintWriter("/home/donglai/Desktop/RNA/GS/test_2/"+(i+1)+"/seq.fa");
			for(j=0;j<4;j++){
			read=in.readLine();
			out_pu.println(read);
			}
		
			in.close();
			out_pu.close();
		}
		
	}
	public void true_stu(String from,String to) throws Exception{
		String[] name={"Cobalamin","gcvT", "glmS" , "purine" , "RFN" , "sbox", "THI" , "tRNA" , "U1","yybp-ykoY"};
		String[] seq={"BX572595_1_86162_86360",
		"CR378670_1_15794_15904",
		"AB006424_1_2989_3156",
		"AP001509_1_79478_79577",
		"AF269712_1_1300_1435",
		"AP003193_2_95783_95678",
		"AP003190_2_118314_118418",
		"X93334_1_6942_7009",
		"L33345_1_2_156",
		"AE017002_1_74863_74734"};
		int i;
		for(i=0;i<10;i++){
		P_pss(from+name[i]+"/"+seq[i]+".pss", to+(i+1)+"/true_stu.pss");
		}
	}
	
	
	public static void main(String arg[]) throws Exception {
	//aln
		int i,j;
//		Test t=new Test();
		//t.true_stu("/home/donglai/Desktop/RNA/data/known_str/","/home/donglai/Desktop/RNA/GS/test_2/");
		
		Parser p=new Parser();
		p.Rfam_seq("/home/donglai/Desktop/RNA/ribo/G_new/5/mat.aln",5);
		String[] seq={"BX572595_1_86162_86360",
				"AP003011_2_321703_321523",
				"AE016783_1_53812_53604",
				"AE017037_1_59439_59627",
				"Z94723_1_23034_23246"		
		};
	//	for(i=0;i<5;i++){
	//	t.P_pss("/home/donglai/Desktop/ribo/truth/"+seq[i]+".pss", "/home/donglai/Desktop/ribo/truth/"+(i+1)+"stu.pss");
	//	}
		//t.fiv2tw("/home/donglai/Desktop/RNA/data/ori_seq/");
		//for (i=649;i<668;i++){
		//	System.out.println(i);
		//  t.P_aln("/home/donglai/Desktop/RNA/GS/toy1/test1/"+i+".aln","/home/donglai/Desktop/RNA/GS/toy1/test1/aln_p",i);
		//}
		//for (i=630;i<669;i++){
		//	t.P_sto("/home/donglai/Desktop/RNA/GS/toy1/test1/"+i+".sto","/home/donglai/Desktop/RNA/GS/toy1/test1/sto_p",i);
		//	}
	}
}
