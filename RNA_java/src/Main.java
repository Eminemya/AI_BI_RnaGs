import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;




public class Main {
	public static void main(String arg[]) throws IOException {
		//new Percent("/home/donglai/Desktop/GS/toy1/1.sto_p","/home/donglai/Desktop/GS/toy1/BX572595_1_86162_86360.pss_p");
		
        Callterm call= new Callterm();		
        Parser par=new Parser();
		int i;
		int num_seq=2;  
	    String test="/home/donglai/Desktop/RNA/ribo/pseudo/"+3+"/";
		String response=new String();
	    	    
	    PrintWriter out_pu2;
	    PrintWriter out_pu;
	    
	    response=par.P_matlab(test+"mat.aln",num_seq);
	    //System.out.println(response);
	    par.C_aln(test+"1.aln",response,num_seq);
	    File f;
	    for(i=1;i<1;i++){
     	 
	    System.out.println(i);  
	    response=null;
	    while(response==null){response=call.Call("RNAalifold -se 1 "+test+i+".aln ",1);}
	    response=response.trim();
	    //System.out.println(response);
	    out_pu= new PrintWriter((new FileWriter(test+"00stru.file", true)));
	    out_pu.println(">structure "+i);
		out_pu.println(response);
		out_pu.close();
		String[] aln=par.C_sto(test+i+".aln",test+i+".sto", response,num_seq);
		 //System.out.println(aln.length);
		out_pu2 = new PrintWriter((new FileWriter(test+"00aln.file", true)));
		out_pu2.println(">alignment "+i);
		for(int w=0;w<num_seq;w++){
		out_pu2.println(aln[w]);
		//System.out.println(aln[w]);
		}
		out_pu2.flush();
		out_pu2.close();
		f = new File(test+i+".cm");
		while(!f.exists()){	System.out.println("haha");	call.Call("cmbuild -F "+test+i+".cm "+test+i+".sto ",0);}
		response=call.Call("cmalign --sample "+test+i+".cm "+test+"seq.fa",2);
		 //System.out.println("cmalign --sample "+test+i+".cm "+test+ww+"seq_set0.fa");
		while(response==null||response.length()<30){
		   response=call.Call("cmalign --sample "+test+i+".cm "+test+"seq.fa",2);
		   System.out.println("response");
		}		
		par.C_aln(test+(i+1)+".aln",response,num_seq);
		
		f = new File(test+i+".aln");
		f.delete();
		f = new File(test+i+".cm");
		f.delete();
		f = new File(test+i+".sto");
 		f.delete();
	    }

	    
		
		//System.out.println((int)Math.ceil();
//		par.P_sto("/home/donglai/Desktop/RNA/GS/toy1/1.sto","/home/donglai/Desktop/RNA/GS/toy1/1.sto_p");
//		par.P_pss("/home/donglai/Desktop/RNA/GS/toy1/AP003011_2_321703_321523.pss","/home/donglai/Desktop/RNA/GS/toy1/AP003011_2_321703_321523.pss_p");
//		par.P_pss("/home/donglai/Desktop/RNA/GS/toy1/BX572595_1_86162_86360.pss","/home/donglai/Desktop/RNA/GS/toy1/BX572595_1_86162_86360.pss_p");
		//par.P_aln("/home/donglai/Desktop/RNA/GS/toy1/0.aln","/home/donglai/Desktop/RNA/GS/toy1/0.aln_p");
	}
}
