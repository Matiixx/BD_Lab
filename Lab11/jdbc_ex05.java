import java.sql.*;

public class jdbc_ex05 {
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
        // Wykorzystanie obiektu CallableStatement i funkcji zwracajacej jeden rekord
        //
        CallableStatement cst = c.prepareCall("{call lab11prep.f1_osoba(?)}");
        cst.setInt(1, 4);

        ResultSet rs;
        rs = cst.executeQuery();
        while (rs.next()) {
          String nazwisko = rs.getString(1);
          System.out.print("Pytanie 1 - wynik:  ");
          System.out.println(nazwisko);
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