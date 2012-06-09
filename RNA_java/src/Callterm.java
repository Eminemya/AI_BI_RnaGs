import java.io.*;

public class Callterm {

	public String Call(String command, int back) {
		StringBuffer outt = new StringBuffer();
		String output=null;
		try {
			//int c, i;
			Process child = Runtime.getRuntime().exec(command);
			//System.out.println(command);
			if (back > 0) {
				BufferedReader in = new BufferedReader(new InputStreamReader(
				  		child.getInputStream()));
				String line = in.readLine();
				while (line!= null) {
					outt.append("\n").append(line);
					line = in.readLine();
					//System.out.println(line);
				}
				in.close();

				String[] cd = outt.substring(0).split("\n");
				if (back == 1) {
					//.aln
	//				System.out.println(cd[0]);
	//				System.out.println(cd[1]);
					String[] tmp = cd[3].split(" ");
					//System.out.println(cd[5]);
					//System.out.println(cd[6]);
					output = tmp[0];
					// System.out.println(cd[cd.length-2]);
				} else {
					//.sto
					output = clean(cd);
					
				}
			}
			//Runtime.getRuntime().exec("exit");
		} catch (IOException e) {
		}
		return output;
	}

		public String clean(String[] cd) {
		StringBuffer outt=new StringBuffer();
		int c = 0;
		System.out.println("heloo wo");
		System.out.println(cd.length);
		while (c <= cd.length - 1 && !cd[c].contains("STOCKHOLM")) {
			System.out.println(cd[c]);
			c = c + 1;
		}

		while (c <= cd.length - 1 && !cd[c].contains("//")) {
			if (!cd[c].contains("#") && cd[c].trim().length() != 0) {
				outt.append(",").append(cd[c]);
			}
			// System.out.println(outt2);
			c = c + 1;
		}
		// System.out.println(outt2+back);
		// System.out.println(outt);
		if (outt.length() >= 1) {
			return outt.substring(1);
		}else{
			return outt.substring(0);			
		}
			



	}
}
