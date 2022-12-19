/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "test.sqc"
#include <stdio.h>
//#include "test.h"
#include "sqlca.h"

const char const * dbase = "u0cichostepski";
const char const * user = "u0cichostepski";
const char const * pass = "0cichostepski";

/* exec sql begin declare section */
     
     
      
     

#line 10 "test.sqc"
 char dbname [ 1024 ] ;
 
#line 11 "test.sqc"
 char db [ 15 ] ;
 
#line 12 "test.sqc"
 char usr [ 15 ] ;
 
#line 13 "test.sqc"
 char pas [ 15 ] ;
/* exec sql end declare section */
#line 14 "test.sqc"

 
int
main()
{
    strncpy(db,dbase,15);
    strncpy(usr,user,15);
    strncpy(pas,pass,15);
    { ECPGconnect(__LINE__, 0, db , usr , pas , "con1", 0); }
#line 22 "test.sqc"

 
    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_database ( )", ECPGt_EOIT, 
	ECPGt_char,(dbname),(long)1024,(long)1,(1024)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 24 "test.sqc"

    printf("current database=%s \n", dbname);
 
    { ECPGdisconnect(__LINE__, "ALL");}
#line 27 "test.sqc"

    return 0;
}