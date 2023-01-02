import java.sql.*;

public class jdbc_ex06 {
  public static void main(String[] argv) {
    /*
     * System.out.
     * println("Sprawdzenie czy sterownik jest zarejestrowany w menadzerze");
     * try {
     * Class.forName("org.postgresql.Driver");
     * } catch (ClassNotFoundException cnfe) {
     * System.out.println("Nie znaleziono sterownika!");
     * System.out.println("Wyduk sledzenia bledu i zakonczenie.");
     * cnfe.printStackTrace();
     * System.exit(1);
     * }
     * System.out.
     * println("Zarejstrowano sterownik - OK, kolejny krok nawiazanie polaczenia z baza danych."
     * );
     */
    Connection c = null;

    try {
      // Wymagane parametry polaczenia z baza danych:
      // Pierwszy - URL do bazy danych:
      // jdbc:dialekt SQL:serwer(adres + port)/baza w naszym przypadku:
      // jdbc:postgres://pascal.fis.agh.edu.pl:5432/baza
      // Drugi i trzeci parametr: uzytkownik bazy i haslo do bazy
      c = DriverManager.getConnection("jdbc:postgresql://pascal.fis.agh.edu.pl:5432/u0cichostepski",
          "u0cichostepski", "0cichostepski");
    } catch (SQLException se) {
      System.out.println("Brak polaczenia z baza danych, wydruk logu sledzenia i koniec.");
      se.printStackTrace();
      System.exit(1);
    }
    if (c != null) {
      System.out.println("Polaczenie z baza danych OK ! ");
      try {
        // Statement st = c.createStatement();
        // ResultSet rs = st.executeQuery("SELECT id, fname, lname FROM lab11.osoba");
        // c.setAutoCommit(false) ;
        CallableStatement cst = c.prepareCall("{ call lab11prep.get_table() }");
        // cst.registerOutParameter(1,Types.OTHER) ;
        cst.execute();
        // System.out.println(cst.getObject(1)) ;

        // ResultSet rs = (ResultSet) cst.getObject(1) ;
        ResultSet rs = cst.executeQuery();
        while (rs.next()) {
          // Int pesel = rs.getInt(1) ;
          String imie = rs.getString(2);
          String nazwisko = rs.getString(3);
          System.out.print("Pytanie 1 - wynik:  ");
          System.out.println(nazwisko + " " + imie);
        }
        rs.close();

        cst.close();
      } catch (SQLException e) {
        System.out.println("Blad podczas przetwarzania danych:" + e);
      }

    } else
      System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");
  }
}