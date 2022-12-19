/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "test7_1.sqc"
#include <stdio.h>
#include "test.h"
 
/* exec sql begin declare section */
     
     
     
     
     
     
         
     
     
     

#line 5 "test7_1.sqc"
 char dbname [ 1024 ] ;
 
#line 6 "test7_1.sqc"
 char db [ 15 ] ;
 
#line 7 "test7_1.sqc"
 char usr [ 15 ] ;
 
#line 8 "test7_1.sqc"
 char pas [ 15 ] ;
 
#line 9 "test7_1.sqc"
 char insertStmt [ 100 ] ;
 
#line 10 "test7_1.sqc"
 char sqlStmt [ 150 ] ;
 
#line 11 "test7_1.sqc"
 int id ;
 
#line 12 "test7_1.sqc"
 char fname [ 20 ] ;
 
#line 13 "test7_1.sqc"
 char lname [ 20 ] ;
 
#line 14 "test7_1.sqc"
 int par_val ;
/* exec sql end declare section */
#line 15 "test7_1.sqc"


static void handle_error(void);
int main()
{
 
   /* exec sql whenever sqlerror  do handle_error ( ) ; */
#line 21 "test7_1.sqc"

   ECPGdebug(1,stderr);
   strncpy(db,dbase,15);
   strncpy(usr,user,15);
   strncpy(pas,pass,15);
   { ECPGconnect(__LINE__, 0, db , usr , pas , "con1", 0); 
#line 26 "test7_1.sqc"

if (sqlca.sqlcode < 0) handle_error ( );}
#line 26 "test7_1.sqc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "set SEARCH_PATH to \"lab9prep\"", ECPGt_EOIT, ECPGt_EORT);
#line 27 "test7_1.sqc"

if (sqlca.sqlcode < 0) handle_error ( );}
#line 27 "test7_1.sqc"

 
   
   strncpy(sqlStmt,"SELECT customer_id, fname, lname FROM customer WHERE customer_id = ?", 100);
   { ECPGprepare(__LINE__, NULL, 0, "s1", sqlStmt);
#line 31 "test7_1.sqc"

if (sqlca.sqlcode < 0) handle_error ( );}
#line 31 "test7_1.sqc"

   par_val = 75; 
   { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_execute, "s1", 
	ECPGt_int,&(par_val),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EOIT, 
	ECPGt_int,&(id),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(fname),(long)20,(long)1,(20)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(lname),(long)20,(long)1,(20)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);
#line 33 "test7_1.sqc"

if (sqlca.sqlcode < 0) handle_error ( );}
#line 33 "test7_1.sqc"
 
   printf("Zwrocony rekord:  %d  %s  %s\n",id,fname,lname);
   fprintf(stderr, "ok\n");
   return 0;
}
static void handle_error(void)
{
   fprintf(stderr, "%s\n", sqlca.sqlerrm.sqlerrmc);
   /* exec sql whenever sqlerror  continue ; */
#line 41 "test7_1.sqc"

   /* EXEC SQL ROLLBACK RELEASE; */
}