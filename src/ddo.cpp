#include <iostream>
#include <string>

#include "DDO.h"

using namespace std;

template<class _F>
int do_filter(_F& filter)
{
    while(!cin.eof())
    {
        double data;
        cin >> data;
        if (!cin.good()) return -1;
        filter.update(data);
        cout << filter.x();
        cout << '\t' << filter.dxdt();
        cout << endl;
    }
    return 0;
}

int main(int argn, char** argv)
{
    double dt = 1.; // interval
    double z = INVSQRT2; // damping factor

    const char* usage =
        "Usage:\n"
        "  ddo [options] \n"
        "\n"
        "DDO filter. Takes the input signal from stdin as a stream of \n"
        "ascii-coded real values until eof or a non-numeric input\n"
        "is encountered.\n"
        "Output is written to stdout, 2 tab-separated values per iteration:\n"
        "filtered signal and time derivative.\n"
        "\n"
        "Options:\n"
        "  -dtX : time interval X (default = 1.0) \n"
        "  -zX  : damping factor X>0, (default = 1/sqrt(2)) \n"
        "  -h   : display this help message\n"
        "\n"
        "Use redirection for file input/output, e.g.:\n"
        "  ddo < in.dat > out.dat\n";

    // parse options
    for(int i=1; i<argn; i++) {
        string opt(argv[i]);
        if (opt.find("-dt")==0) { // interval
            opt.erase(0,3);
            dt = atof(opt.c_str());
        }
        else if (opt.find("-z")==0) { // damping factor
            opt.erase(0,2);
            z = atoi(opt.c_str());
        }
        else if (opt.find("-h")==0) { // help
            cout << usage;
            return 0;
        }
        else {
            cout << "Invalid option: " << opt << endl;
            cout << usage;
            return -1;
        }
    }

    DDO<double> ddo(dt,z);

    while(!cin.eof())
    {
        double data;
        cin >> data;
        if (!cin.good()) return -1;
        ddo.update(data);
        cout << ddo.x();
        cout << '\t' << ddo.dxdt();
        cout << endl;
    }

    return 0;
}




