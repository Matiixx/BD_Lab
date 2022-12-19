/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "lab9.sqc"
#include <stdio.h>
#include "lab9.h"

/* exec sql begin declare section */
     
     
     
     
     
     
     
     
     

#line 5 "lab9.sqc"
 char dbname [ 1024 ] ;
 
#line 6 "lab9.sqc"
 char db [ 15 ] ;
 
#line 7 "lab9.sqc"
 char usr [ 15 ] ;
 
#line 8 "lab9.sqc"
 char pas [ 15 ] ;
 
#line 9 "lab9.sqc"
 char sch [ 15 ] ;
 
#line 10 "lab9.sqc"
 char id_arg [ 5 ] ;
 
#line 11 "lab9.sqc"
 int id ;
 
#line 12 "lab9.sqc"
 char desc [ 20 ] ;
 
#line 13 "lab9.sqc"
 int quant ;
/* exec sql end declare section */
#line 14 "lab9.sqc"


int main(int argc, char **argv) {

    if(argc == 1)
    {
        printf("Podaj id podczas wywolania\n");
        return 0;
    }

    strncpy(db,dbase,15);
    strncpy(usr,user,15);
    strncpy(pas,pass,15);
    strncpy(sch,schema,15);
    strncpy(id_arg,argv[1],5);
    { ECPGconnect(__LINE__, 0, db , usr , pas , "con1", 0); }
#line 29 "lab9.sqc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "set SEARCH_PATH to $0", 
	ECPGt_char,(sch),(long)15,(long)1,(15)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EOIT, ECPGt_EORT);}
#line 30 "lab9.sqc"


    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_database ( )", ECPGt_EOIT, 
	ECPGt_char,(dbname),(long)1024,(long)1,(1024)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 32 "lab9.sqc"

    printf("current database=%s\nWyszukiwanie zamowien dla uzytkownika o id=%s \n", dbname, id_arg);

    /* declare c1 cursor for select oi . orderinfo_id , i . description , ol . quantity from orderinfo oi join orderline ol using ( orderinfo_id ) join item i using ( item_id ) where oi . customer_id = $1  */
#line 35 "lab9.sqc"


    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "declare c1 cursor for select oi . orderinfo_id , i . description , ol . quantity from orderinfo oi join orderline ol using ( orderinfo_id ) join item i using ( item_id ) where oi . customer_id = $1 ", 
	ECPGt_char,(id_arg),(long)5,(long)1,(5)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EOIT, ECPGt_EORT);}
#line 37 "lab9.sqc"

    printf("[\n");
    while(sqlca.sqlcode == 0) {
        { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch c1", ECPGt_EOIT, 
	ECPGt_int,&(id),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(desc),(long)20,(long)1,(20)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_int,&(quant),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 40 "lab9.sqc"

        if (SQLCODE == 0) 
            printf(" {\"orderinfo_id\":%d,\"description\":\"%s\",\"quantity\":%d},\n", id, desc, quant);
    }
    printf("]\n");
    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "close c1", ECPGt_EOIT, ECPGt_EORT);}
#line 45 "lab9.sqc"


    { ECPGdisconnect(__LINE__, "ALL");}
#line 47 "lab9.sqc"


    return 0;
}