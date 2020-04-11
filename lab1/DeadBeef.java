import java.io.*;

class DeadBeef
{
	public static void main(String[] args) throws IOException
	{
		FileWriter fileWriter = new FileWriter("Output.txt");
		PrintWriter out = new PrintWriter(fileWriter);

		for(int i = 1; i <= 1000; i++)
		{
			if(i%36 == 0)
			{
				out.println("DEADBEEF");
			}
			else if(i%9 == 0)
			{
				out.println("BEEF");
			}
			else if(i%4 == 0)
			{
				out.println("DEAD");
			}
			else
			{
				out.println(i);
			}
		}

		out.close();
	}
}