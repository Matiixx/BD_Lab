/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "test6_2.sqc"
#include <stdio.h>
#include "test.h"
  
/* exec sql begin declare section */
     
     
     
     
     
     
     

#line 5 "test6_2.sqc"
 char db [ 15 ] ;
 
#line 6 "test6_2.sqc"
 char usr [ 15 ] ;
 
#line 7 "test6_2.sqc"
 char pas [ 15 ] ;
 
#line 8 "test6_2.sqc"
 char dbname [ 1024 ] ;
 
#line 9 "test6_2.sqc"
 int id ;
 
#line 10 "test6_2.sqc"
 char fname [ 20 ] ;
 
#line 11 "test6_2.sqc"
 char lname [ 20 ] ;
/* exec sql end declare section */
#line 12 "test6_2.sqc"

  
int main()
{
    strncpy(db,dbase,15);
    strncpy(usr,user,15);
    strncpy(pas,pass,15);
    /* ECPGdebug(1,stderr);  */
    { ECPGconnect(__LINE__, 0, db , usr , pas , "con1", 0); }
#line 20 "test6_2.sqc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "set SEARCH_PATH to \"lab9prep\"", ECPGt_EOIT, ECPGt_EORT);}
#line 21 "test6_2.sqc"

  
    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_database ( )", ECPGt_EOIT, 
	ECPGt_char,(dbname),(long)1024,(long)1,(1024)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 23 "test6_2.sqc"

    printf("current database=%s \n", dbname);
  
    /* declare c1 cursor for select customer_id , fname , lname from customer */
#line 26 "test6_2.sqc"

  
    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "declare c1 cursor for select customer_id , fname , lname from customer", ECPGt_EOIT, ECPGt_EORT);}
#line 28 "test6_2.sqc"

  while(sqlca.sqlcode == 0) {
    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch c1", ECPGt_EOIT, 
	ECPGt_int,&(id),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(fname),(long)20,(long)1,(20)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(lname),(long)20,(long)1,(20)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 30 "test6_2.sqc"

     if (SQLCODE == 0) 
       printf("%d  %s  %s\n",id,fname,lname);
   }
    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "close c1", ECPGt_EOIT, ECPGt_EORT);}
#line 34 "test6_2.sqc"

  
    { ECPGdisconnect(__LINE__, "ALL");}
#line 36 "test6_2.sqc"

    return 0;
}