import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;


public class Percent {
	BufferedReader in;
	PrintWriter out_pu;
public Percent(String from, String to) throws IOException{
	in = new BufferedReader(new FileReader(from));
	String a=in.readLine();
	in = new BufferedReader(new FileReader(to));
	String b=in.readLine();
	System.out.println(a);
	System.out.println(b);
}
	
}