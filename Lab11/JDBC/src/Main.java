import java.sql.*;

public class Main {

    public static void f1(Connection c, int id) {
        try {
            c.setAutoCommit(false);
            CallableStatement cst = c.prepareCall("{ ? = call lab11.F_1(?)}");
            cst.setInt(2, id);
            cst.registerOutParameter(1, Types.OTHER);
            cst.execute();
            ResultSet rs = (ResultSet) cst.getObject(1);
            System.out.println("Towary uzytkownika o id " + id);
            while (rs.next()) {
                String opis = rs.getString(2);
                String ilosc = rs.getString(3);
                System.out.println(" " + opis + " ilosc: " + ilosc);
            }
            rs.close();
            cst.close();
        } catch (SQLException e) {
            System.out.println("Blad podczas przetwarzania danych:" + e);
        }
    }

    public static void zakupyNazwisko(Connection c, String nazwisko) {
        try {
            PreparedStatement pst = c.prepareStatement("SELECT customer_id FROM lab11.customer WHERE lname=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            pst.setString(1, nazwisko);
            ResultSet rs;
            rs = pst.executeQuery();
            while (rs.next()) {
                f1(c, rs.getInt(1));
                System.out.println();
            }
        } catch (SQLException e) {
            System.out.println("Blad podczas przetwarzania danych:" + e);
        }


    }

    public static void dodajZakup(Connection c, int customer_id, int item_id, int quantity) {
        if (c != null) {
            try {
                c.setAutoCommit(false);
                PreparedStatement pst = c.prepareStatement("INSERT INTO lab11.orderinfo (customer_id, date_placed, date_shipped, shipping) VALUES (?,?,?,?) RETURNING *");
                pst.setInt(1, customer_id);
                pst.setDate(2, new Date(System.currentTimeMillis()));
                pst.setDate(3, new Date(System.currentTimeMillis()));
                pst.setDouble(4, 9.9);

                ResultSet rs;
                rs = pst.executeQuery();
                int orderinfo_id;
                if (rs.next()) {
                    orderinfo_id = rs.getInt(1);
                } else {
                    throw new SQLException();
                }

                pst = c.prepareStatement("INSERT INTO lab11.orderline(orderinfo_id, item_id, quantity) VALUES(?,?,?) RETURNING *");
                pst.setInt(1, orderinfo_id);
                pst.setInt(2, item_id);
                pst.setInt(3, quantity);

                rs = pst.executeQuery();
                if (rs.next()) {
                    System.out.println("Dodano zakup");
                } else {
                    throw new SQLException();
                }
                c.commit();
                pst.close();
            } catch (SQLException e) {
                System.out.println("Blad podczas przetwarzania danych:" + e);
            }

        } else
            System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");
    }

    public static void main(String[] args) {
        Connection c = null;

        try {
            c = DriverManager.getConnection("jdbc:postgresql://pascal.fis.agh.edu.pl:5432/u0cichostepski",
                    "u0cichostepski", "0cichostepski");
        } catch (SQLException se) {
            System.out.println("Brak polaczenia z baza danych, wydruk logu sledzenia i koniec.");
            se.printStackTrace();
            System.exit(1);
        }
        if (c != null) {
            System.out.println("Polaczenie z baza danych OK ! ");

            dodajZakup(c, 1, 3, 4);
            zakupyNazwisko(c, "Stones");


        } else
            System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");
    }
}