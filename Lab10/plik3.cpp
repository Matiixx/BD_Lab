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

      std::string selectStatement = "SELECT id, fname, lname FROM lab10prep.person";

      stateless_cursor<pqxx::cursor_base::read_only, pqxx::cursor_base::owned>
          person_cursor(trsxn, selectStatement, "personCursor", false);

      size_t idx = 0;  // start from 0
      size_t step = 3; // ilosc rekordow w porcji
      result res;
      do
      {
        // fetch next cursor
        res = person_cursor.retrieve(idx, idx + step);
        idx += step;

        size_t records = res.size();

        for (const pqxx::result::const_iterator &&row : res)
        {
          cout << row["lname"].as<std::string>() << '\t' << row["fname"].as<std::string>()
               << '\t' << row["id"].as<int>() << endl;
        }
      } while (res.size() == step); // jezeli the res.size() != step to jest to ostatnia petla
      cout << " Sukces - wykonano" << endl;

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