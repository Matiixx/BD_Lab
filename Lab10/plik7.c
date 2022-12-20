#include <stdlib.h>
#include <libpq-fe.h>
#include <stdio.h>

/* for ntohl/htonl */
#include <netinet/in.h>
#include <arpa/inet.h>

void printTuples(PGresult *result)
{
  int n = 0, r = 0;
  int nrows = PQntuples(result);
  int nfields = PQnfields(result);
  printf("number of rows returned = %d\n", nrows);
  printf("number of fields returned = %d\n", nfields);
  for (r = 0; r < nrows; r++)
  {
    for (n = 0; n < nfields; n++)
      printf(" %s = %s", PQfname(result, n), PQgetvalue(result, r, n), PQgetlength(result, r, n));
    printf("\n");
  }
}

int main()
{
  PGresult *result;
  PGconn *conn;
  // Prepered statement
  const char *stmtName;
  const char *query;
  int nParams;

  const char *paramValues[1];
  int paramLengths[1];
  int paramFormats[1];
  uint32_t binaryIntVal;

  const char *connection_str = "host=localhost port=5432 dbname=u0cichostepski user=u0cichostepski password=0cichostepski";
  stmtName = "SQL1";
  query = "SELECT * FROM lab10prep.person WHERE fname = $1";
  conn = PQconnectdb(connection_str);
  if (PQstatus(conn) == CONNECTION_BAD)
  {
    fprintf(stderr, "Connection to %s failed, %s", connection_str, PQerrorMessage(conn));
  }
  else
  {
    printf("Connected OK\n");

    /* Prepere statement */
    query = "SELECT * FROM lab10prep.person WHERE id= $1";
    stmtName = "Query";
    nParams = 1;
    PGresult *pPreperedQuery = PQprepare(conn, stmtName, query, nParams, NULL);

    /* Execute prepered statement id=31 */
    /* Convert integer value "31" to network byte order */
    binaryIntVal = htonl((uint32_t)1);

    /* Set up parameter arrays for PQexecParams */
    paramValues[0] = (char *)&binaryIntVal;
    paramLengths[0] = sizeof(binaryIntVal);
    paramFormats[0] = 1; /* binary */

    result = PQexecPrepared(conn, stmtName, nParams,
                            paramValues,
                            paramLengths,
                            paramFormats,
                            0); /* ask for binary results */

    if (PQresultStatus(result) != PGRES_TUPLES_OK)
    {
      fprintf(stderr, "SELECT failed: %s", PQerrorMessage(conn));
      PQclear(result);
    }
    else
      printTuples(result);

    /* Execute prepered statement id=10*/
    /* Convert integer value "10" to network byte order */
    binaryIntVal = htonl((uint32_t)8);

    /* Set up parameter arrays for PQexecParams */
    paramValues[0] = (char *)&binaryIntVal;
    paramLengths[0] = sizeof(binaryIntVal);
    paramFormats[0] = 1; /* binary */

    result = PQexecPrepared(conn, stmtName, nParams,
                            paramValues,
                            paramLengths,
                            paramFormats,
                            0); /* ask for binary results */

    if (PQresultStatus(result) != PGRES_TUPLES_OK)
    {
      fprintf(stderr, "SELECT failed: %s", PQerrorMessage(conn));
      PQclear(result);
    }
    else
      printTuples(result);

    /* Execute prepered statement id=66*/
    /* Convert integer value "66" to network byte order */
    binaryIntVal = htonl((uint32_t)66);

    /* Set up parameter arrays for PQexecParams */
    paramValues[0] = (char *)&binaryIntVal;
    paramLengths[0] = sizeof(binaryIntVal);
    paramFormats[0] = 1; /* binary */

    result = PQexecPrepared(conn, stmtName, nParams,
                            paramValues,
                            paramLengths,
                            paramFormats,
                            0); /* ask for binary results */

    if (PQresultStatus(result) != PGRES_TUPLES_OK)
    {
      fprintf(stderr, "SELECT failed: %s", PQerrorMessage(conn));
      PQclear(result);
    }
    else
      printTuples(result);

    PQfinish(conn);
    return EXIT_SUCCESS;
  }
}