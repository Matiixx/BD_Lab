#include <stdio.h>
#include <sql.h>
#include <sqlext.h>
#include <string.h>
#include <stdlib.h>

void HandleDiagnosticRecord(SQLHANDLE,SQLSMALLINT,RETCODE);
#define SQL_QUERY_SIZE      1000 
#define PARAM_ARRAY_SIZE 2
 
int main()
{
    SQLHENV     hEnv = NULL;
    SQLHDBC     hDbc = NULL;
    SQLHSTMT    hStmt = NULL;
    //WCHAR*      pwszConnStr;
    //WCHAR       wszInput[SQL_QUERY_SIZE];
    CHAR*      pwszConnStr;
    CHAR       wszInput[SQL_QUERY_SIZE];
    SQLRETURN   ret;
    //char      tmpbuf[256];
    int row = 0;
    SQLINTEGER  customerID[] = { 33,35 };
    SQLUSMALLINT ParamStatusArray[PARAM_ARRAY_SIZE];
    SQLLEN       ParamsProcessed = 0;
 
    // Allocate an environment
    if (SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv) == SQL_ERROR)
    {
        fprintf(stderr, "Unable to allocate an environment handle\n");
        exit(-1);
    }
 
    // Register this as an application that expects 3.x behavior,
    // Allocate a connection
    RETCODE rc = SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0);
    if (rc != SQL_SUCCESS)
    {
        HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
    }
    if (rc == SQL_ERROR)
    {
        fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,    (SQLPOINTER)SQL_OV_ODBC3,0)\n");
        exit(-1);
    }
 
    rc = SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);
    if (rc != SQL_SUCCESS)
    {
        HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
    }
    if (rc == SQL_ERROR)
    {
        fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,    (SQLPOINTER)SQL_OV_ODBC3,0)\n");
        goto Exit;
    }
 
    pwszConnStr = "lab12";
 
    rc = SQLConnect(hDbc, pwszConnStr, SQL_NTS, NULL, 0, NULL, 0);
 
    fprintf(stderr, "Connected!\n");
 
    rc = SQLAllocHandle(SQL_HANDLE_STMT, hDbc, &hStmt);
 
    strcpy(wszInput, "SELECT fname, lname FROM lab11.customer ;"); //WHERE customer_id = ?
 
    RETCODE     RetCode;
    SQLSMALLINT sNumResults;
 
    // Execute the query
    // Prepare Statement
    //RetCode = SQLPrepare(hStmt, wszInput, SQL_NTS);
 
    RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAMSET_SIZE, (SQLPOINTER)PARAM_ARRAY_SIZE, 0);
    RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAM_STATUS_PTR, ParamStatusArray, PARAM_ARRAY_SIZE);
    RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAMS_PROCESSED_PTR, &ParamsProcessed, 0);
 
    // Bind array values of parameter 1
    RetCode = SQLBindParameter(hStmt, 1, SQL_PARAM_INPUT, SQL_C_LONG,
        SQL_INTEGER, 0, 0, customerID+1, 0, NULL);
 
    RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);
    //RetCode = SQLExecute(hStmt);
    //RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);
 
 
    // Retrieve number of columns
    rc = SQLNumResultCols(hStmt, &sNumResults);
    printf("Number of Result Columns %i\n", sNumResults);
 
     
    switch (RetCode)
    {
    case SQL_SUCCESS_WITH_INFO:
    {
        HandleDiagnosticRecord(hStmt, SQL_HANDLE_STMT, RetCode);
    }
    case SQL_SUCCESS:
    {
        rc = SQLNumResultCols(hStmt, &sNumResults);
 
        if (sNumResults > 0)
        {
            //DisplayResults(hStmt, sNumResults);
            while (SQL_SUCCEEDED(ret = SQLFetch(hStmt))) {
                SQLUSMALLINT i;
                printf("Row %d\n", row++);
                // Loop through the columns
                for (i = 1; i <= sNumResults; i++) {
                    SQLLEN indicator;
                    //SQLWCHAR buf[512];
                    SQLCHAR buf[512];
                    // retrieve column data as a string
                    ret = SQLGetData(hStmt, i, SQL_C_CHAR,  buf, sizeof(buf), &indicator);
                    //ret = SQLGetData(hStmt, i, SQL_C_WCHAR,   buf, sizeof(buf), &indicator);
                    if (SQL_SUCCEEDED(ret)) {
                        // Handle null columns
                        if (indicator == SQL_NULL_DATA) strcpy(buf, "NULL");
                        printf("  Column %u : %s\n", i, buf);
                    }
                }
            }
        }
        else
        {
            SQLLEN cRowCount;
 
            rc = SQLRowCount(hStmt, &cRowCount);
            if (cRowCount >= 0)
            {
                printf("%d %s affected\n", cRowCount, cRowCount == 1 ? "row" : "rows");
            }
        }
        break;
    }
 
    case SQL_ERROR:
    {
        HandleDiagnosticRecord(hStmt, SQL_HANDLE_STMT, RetCode);
        break;
    }
 
    default:
        fprintf(stderr, "Unexpected return code %hd!\n", RetCode);
 
    }
    rc = SQLFreeStmt(hStmt, SQL_CLOSE);
 
Exit:
 
    if (hStmt)
    {
        SQLFreeHandle(SQL_HANDLE_STMT, hStmt);
    }
 
    if (hDbc)
    {
        SQLDisconnect(hDbc);
        SQLFreeHandle(SQL_HANDLE_DBC, hDbc);
    }
 
    if (hEnv)
    {
        SQLFreeHandle(SQL_HANDLE_ENV, hEnv);
    }
 
    printf("\nUFF - pozamiatane\n");
 
    return 0;
}
 
//
void HandleDiagnosticRecord(SQLHANDLE hHandle,
    SQLSMALLINT    hType,
    RETCODE        RetCode)
{
    SQLSMALLINT iRec = 0;
    SQLINTEGER  iError;
    //WCHAR       wszMessage[1000];
    //WCHAR       wszState[SQL_SQLSTATE_SIZE + 1];
        CHAR       wszMessage[1000];
    CHAR       wszState[SQL_SQLSTATE_SIZE + 1];
 
 
    if (RetCode == SQL_INVALID_HANDLE)
    {
        fprintf(stderr, "Invalid handle!\n");
        return;
    }
 
    while (SQLGetDiagRec(hType, hHandle, ++iRec, wszState,
        &iError, wszMessage,
        (SQLSMALLINT)(sizeof(wszMessage) / sizeof(WCHAR)),
        (SQLSMALLINT *)NULL) == SQL_SUCCESS)
    {
        // Hide data truncated..
        if (strncmp(wszState, "01004", 5))
        {
            fprintf(stderr, "[%5.5s] %s (%d)\n", wszState, wszMessage, iError);
        }
    }
}