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
  string fname("Tik");
  string lname("Tak");
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

      // konstrukcja polecenia update
      connlab.prepare("update_person", "UPDATE lab10prep.person SET  lname = $1, fname = $2 WHERE id = $3");
      prepare::invocation update_invocation = trsxn.prepared("update_person")(lname.c_str())(fname.c_str())(id);

      // wykonanie
      result res = update_invocation.exec();
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