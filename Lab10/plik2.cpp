#include <iostream>
#include <sstream>
#include <string>
#include <pqxx/pqxx>
#include "lab10.h"

using namespace std;
using namespace pqxx;

int main(int argc, char *argv[])
{

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

      result res{trsxn.exec("SELECT id, fname, lname FROM lab10prep.person")};
      for (const auto &&row : res)
        cout << row["id"].as<int>() << " " << row[2].c_str() << " " << row[1].c_str() << std::endl;

      // dla polecenia select niekoniecznie
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