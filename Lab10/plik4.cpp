#include <iostream>
#include <sstream>
#include <string>
#include <pqxx/pqxx>
#include "lab10.h"

using namespace std;
using namespace pqxx;

int main(int argc, char *argv[])
{
  int id = 101;
  string fname("And");
  string lname("Lem");
  if (argc == 4)
  {
    id = atoi(argv[1]);
    fname = argv[2];
    lname = argv[3];
  }

  stringstream ss;
  ss << "dbname = " << labdbname << " user = " << labdbuser << " password = " << labdbpass
     << " host = " << labdbhost << " port = " << labdbport;
  string s = ss.str();

  try
  {
    connection connlab(s);
    if (connlab.is_open())
    {

      work trsxn{connlab};

      // konstrukcja polecenia insert
      connlab.prepare("insert_person", "INSERT INTO lab10prep.person ( id, lname, fname ) VALUES ($1, $2, $3)");
      prepare::invocation insert_invocation = trsxn.prepared("insert_person")(id)(lname.c_str())(fname.c_str());

      // dynamic array preparation
      // prep_dynamic(ids, w_invocation);

      // wykonanie
      result res = insert_invocation.exec();
      trsxn.commit();
    }
    else
    {
      cout << "Problem z connection " << endl;
      return 3;
    }
    connlab.disconnect();
  }
  catch (pqxx::sql_error const &e)
  {
    cerr << "SQL error: " << e.what() << std::endl;
    cerr << "Polecenie SQL: " << e.query() << std::endl;
    return 2;
  }
  catch (const std::exception &e)
  {
    cerr << e.what() << std::endl;
    return 1;
  }
}