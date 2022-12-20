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
  if (argc == 2)

  {
    id = atoi(argv[1]);
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

      // konstrukcja polecenia delete
      connlab.prepare("delete_person", "DELETE FROM lab10prep.person WHERE id = $1");
      prepare::invocation delete_invocation = trsxn.prepared("delete_person")(id);

      // wykonanie
      result res = delete_invocation.exec();
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