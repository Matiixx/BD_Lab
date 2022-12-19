/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "test2.sqc"
#include <stdio.h>
#include "sqlca.h"

const char const * dbase = "u0cichostepski";
const char const * schema = "lab9prep";
const char const * user = "u0cichostepski";
const char const * pass = "0cichostepski";

/* exec sql begin declare section */
   
   
   
   
   
   
   
   

#line 10 "test2.sqc"
 char db [ 15 ] ;
 
#line 11 "test2.sqc"
 char usr [ 15 ] ;
 
#line 12 "test2.sqc"
 char pas [ 15 ] ;
 
#line 13 "test2.sqc"
 char sch [ 15 ] ;
 
#line 14 "test2.sqc"
 char dbname [ 1024 ] ;
 
#line 15 "test2.sqc"
 int id ;
 
#line 16 "test2.sqc"
 char fname [ 20 ] ;
 
#line 17 "test2.sqc"
 char lname [ 20 ] ;
/* exec sql end declare section */
#line 18 "test2.sqc"


int main() {
  strncpy(db,dbase,15);
  strncpy(usr,user,15);
  strncpy(pas,pass,15);
  strncpy(sch,schema,15);
  { ECPGconnect(__LINE__, 0, db , usr , pas , "con1", 0); }
#line 25 "test2.sqc"

  { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "set SEARCH_PATH to $0", 
	ECPGt_char,(sch),(long)15,(long)1,(15)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EOIT, ECPGt_EORT);}
#line 26 "test2.sqc"

  { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_database ( )", ECPGt_EOIT, 
	ECPGt_char,(dbname),(long)1024,(long)1,(1024)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 27 "test2.sqc"

  printf("current database=%s \n", dbname);

  { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select customer_id , fname , lname from customer limit 1", ECPGt_EOIT, 
	ECPGt_int,&(id),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(fname),(long)20,(long)1,(20)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(lname),(long)20,(long)1,(20)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 30 "test2.sqc"

 
  printf("%d  %s  %s\n",id,fname,lname);

  { ECPGdisconnect(__LINE__, "ALL");}
#line 34 "test2.sqc"

  return 0;

}