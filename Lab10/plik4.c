#include <stdlib.h>
#include <libpq-fe.h>
int main()
{
  PGresult *result;
  PGconn *conn;
  const char *connection_str = "host=localhost port=5432 dbname=u0cichostepski user=u0cichostepski password=0cichostepski";
  conn = PQconnectdb(connection_str);
  if (PQstatus(conn) == CONNECTION_BAD)
  {
    fprintf(stderr, "Connection to %s failed, %s", connection_str, PQerrorMessage(conn));
  }
  else
  {
    result = PQexec(conn, "SELECT id as Nr, fname as Imie, lname as Nazwisko FROM lab10prep.person;");
    {
      PQprintOpt pqp;                // struktura sterująca formatem wydruku
      pqp.header = 1;                // typ pqbool - drukowanie nazw kolumn w nagłówku
      pqp.align = 1;                 // typ pqbool - wyrównanie wyników do innych wierszy
      pqp.html3 = 1;                 // typ pqbool - tabela w postaci HTML
      pqp.expanded = 0;              // typ pqbool - każde pole w oddzielnym wierszu
      pqp.pager = 0;                 // typ pqbool - podział wyniku na strony
      pqp.fieldSep = "";             // typ char - separator pól
      pqp.tableOpt = "align=center"; // typ char - opcje HTML dla <TABLE ...>
      pqp.caption = "Tabela person"; // typ char - wartość <CAPTION> tabeli HTML
      pqp.fieldName = NULL;          // typ char - tablica zamienników nazw pól
      printf("<HTML><HEAD></HEAD><BODY>\n");
      PQprint(stdout, result, &pqp);
      printf("</BODY></HTML>\n");
    }
  }
  PQfinish(conn);
  return EXIT_SUCCESS;
}