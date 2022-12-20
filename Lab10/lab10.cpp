#include <iostream>
#include <sstream>
#include <string>
#include <pqxx/pqxx>
#include "lab10.h"

using namespace pqxx;

std::string generateJSON(const result &res)
{
    std::stringstream s;
    s << "[";
    for (const auto &&rec : res)
    {
        s << "{";
        for (const auto &&col : rec)
        {
            s << "\"" << col.name() << "\":\"" << col << "\",";
        }
        s << "},\n";
    }
    s << "]\n";
    return s.str();
}

// Zayptanie jako argument wywolania

int main(int argc, char *argv[])
{
    if (argc == 2)
    {
        const std::string query = argv[1];

        std::stringstream ss;
        ss << "dbname = " << labdbname << " user = " << labdbuser << " password = " << labdbpass
           << " host = " << labdbhost << " port = " << labdbport;
        std::string s = ss.str();

        try
        {
            connection connlab(s);
            if (connlab.is_open())
            {
                work trsxn{connlab};

                result res{trsxn.exec(query)};

                std::cout << generateJSON(res);

                trsxn.commit();
            }
            else
            {
                std::cout << "Problem z connection " << std::endl;
                return 3;
            }
            connlab.disconnect();
        }
        catch (pqxx::sql_error const &e)
        {
            std::cerr << "SQL error: " << e.what() << std::endl;
            std::cerr << "Polecenie SQL: " << e.query() << std::endl;
            return 2;
        }
        catch (const std::exception &e)
        {
            std::cerr << e.what() << std::endl;
            return 1;
        }
    }
    return 0;
}