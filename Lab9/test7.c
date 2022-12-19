/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "test7.sqc"
#include <stdio.h>
#include "test.h"

/* exec sql begin declare section */
 
 
 
 
 

#line 5 "test7.sqc"
 char dbname [ 1024 ] ;
 
#line 6 "test7.sqc"
 char db [ 15 ] ;
 
#line 7 "test7.sqc"
 char usr [ 15 ] ;
 
#line 8 "test7.sqc"
 char pas [ 15 ] ;
 
#line 9 "test7.sqc"
 char insertStmt [ 100 ] ;
/* exec sql end declare section */
#line 10 "test7.sqc"


static void handle_error(void);
int main()
{

/* exec sql whenever sqlerror  do handle_error ( ) ; */
#line 16 "test7.sqc"

ECPGdebug(1,stderr);
strncpy(db,dbase,15);
strncpy(usr,user,15);
strncpy(pas,pass,15);
{ ECPGconnect(__LINE__, 0, db , usr , pas , "con1 ", 0); 
#line 21 "test7.sqc"

if (sqlca.sqlcode < 0) handle_error ( );}
#line 21 "test7.sqc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "set SEARCH_PATH to \"lab9prep\"", ECPGt_EOIT, ECPGt_EORT);
#line 22 "test7.sqc"

if (sqlca.sqlcode < 0) handle_error ( );}
#line 22 "test7.sqc"


strcpy(insertStmt,"INSERT INTO customer VALUES (75,'Mr','Adam','Adamski','Dluga','krakow','NT3 7RT','267 1232')");

{ ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_exec_immediate, insertStmt, ECPGt_EOIT, ECPGt_EORT);
#line 26 "test7.sqc"

if (sqlca.sqlcode < 0) handle_error ( );}
#line 26 "test7.sqc"
 
//EXECUTE IMMEDIATE automatycznie nie wykonuje COMMIT  przy operacji DML. Trzeba to wykonać osobno.
{ ECPGtrans(__LINE__, NULL, "commit");
#line 28 "test7.sqc"

if (sqlca.sqlcode < 0) handle_error ( );}
#line 28 "test7.sqc"

fprintf(stderr, "ok\n");

return 0;
}

static void handle_error(void)
{
fprintf(stderr, "%s\n", sqlca.sqlerrm.sqlerrmc);
/* exec sql whenever sqlerror  continue ; */
#line 37 "test7.sqc"

/* EXEC SQL ROLLBACK RELEASE; */
}