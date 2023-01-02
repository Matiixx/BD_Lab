import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetTables {
  public static void main(String[] args) {
    Connection connection = null;
    try {
      String serverName = "localhost";
      String baza = "u0cichostepski";
      String url = "jdbc:postgresql://" + serverName + "/" + baza;
      String username = "u0cichostepski";
      String password = "0cichostepski";
      connection = DriverManager.getConnection(url, username, password);
      System.out.println("Successfully Connected to the database!");
    } catch (SQLException e) {
      System.out.println("Could not connect to the database " + e.getMessage());
    }
    try {
      // Get the database metadata
      DatabaseMetaData metadata = connection.getMetaData();
      // Specify the type of object; in this case we want tables
      String[] types = { "TABLE" };
      ResultSet resultSet = metadata.getTables(null, null, "%", types);
      while (resultSet.next()) {
        String tableName = resultSet.getString(3);
        String tableCatalog = resultSet.getString(1);
        String tableSchema = resultSet.getString(2);
        System.out.println(
            "{ schema : '" + tableSchema + "', table : '" + tableName + "' catalog : '" + tableCatalog + "' }");
      }
    } catch (SQLException e) {
      System.out.println("Could not get database metadata " + e.getMessage());
    }
  }
}