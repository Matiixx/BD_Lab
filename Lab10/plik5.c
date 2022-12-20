#include <stdlib.h>
#include <libpq-fe.h>
#include <stdio.h>

int main()
{
  PGresult *result;
  PGconn *conn;
  const char *paramValues[1];
  int paramLengths[1];
  int paramFormats[1];

  const char *connection_str = "host=localhost port=5432 dbname=u0cichostepski user=u0cichostepski password=0cichostepski";
  conn = PQconnectdb(connection_str);
  if (PQstatus(conn) == CONNECTION_BAD)
  {
    fprintf(stderr, "Connection to %s failed, %s", connection_str, PQerrorMessage(conn));
  }
  else
  {
    printf("Connected OK\n");

    /* Set up parameter arrays for PQexecParams */
    paramValues[0] = "Janek";

    result = PQexecParams(conn, "SELECT * FROM lab10prep.person WHERE fname = $1",
                          1,    /* one param */
                          NULL, /* let the backend deduce param type */
                          paramValues,
                          NULL, /* don't need param lengths since text */
                          NULL, /* default to all text params */
                          1);
    /* ask for binary results */

    if (PQresultStatus(result) != PGRES_TUPLES_OK)
    {
      fprintf(stderr, "SELECT failed: %s", PQerrorMessage(conn));
      PQclear(result);
    }
    else
    {
      int n = 0, r = 0;
      int nrows = PQntuples(result);
      int nfields = PQnfields(result);
      printf("number of rows returned = %d\n", nrows);
      printf("number of fields returned = %d\n", nfields);
      for (r = 0; r < nrows; r++)
      {
        for (n = 0; n < nfields; n++)
          printf(" %s = %s", PQfname(result, n), PQgetvalue(result, r, n));
        printf("\n");
      }
    }
    PQfinish(conn);
    return EXIT_SUCCESS;
  }
}