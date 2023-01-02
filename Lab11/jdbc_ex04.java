import java.sql.*;

public class jdbc_ex04 {
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
        // Wstawianie rekordow do bazy danych
        // Wykorzystanie metody executeUpdate()
        PreparedStatement pst = c.prepareStatement("INSERT INTO lab11prep.osoba (id, fname, lname) VALUES (?,?,?)");
        pst.setInt(1, 3);
        pst.setString(2, "Adam");
        pst.setString(3, "Kowalski");
        int rows;
        rows = pst.executeUpdate();
        System.out.print("Polecenie 1 -  INSERT - ilosc dodanych rekordow: ");
        System.out.println(rows);

        pst.setInt(1, 4);
        pst.setString(2, "Michal");
        pst.setString(3, "Mamacki");
        rows = pst.executeUpdate();
        System.out.print("Polecenie 2 -  INSERT - ilosc dodanych rekordow: ");
        System.out.println(rows);

        pst.close();
      } catch (SQLException e) {
        System.out.println("Blad podczas przetwarzania danych:" + e);
      }

    } else
      System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");
  }
}