package trinity.bug.bounty;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {
	private static Connection c;
	public static Connection getConnection() throws ClassNotFoundException, SQLException
	{
		
		Class.forName("org.postgresql.Driver");
		c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/bug_bounty", "postgres", "purav");
		c.setAutoCommit(false);
		return c;
	}
}