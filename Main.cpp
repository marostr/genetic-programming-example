#include <iostream>
#include <string>

using namespace std;

int main() {
    char t[] = " abcdefghijklmnoprstuwxyz";
    int len = 26;
    int pos = 0;
    string s;
    while(cin >> s) {
        if(s == "exit") break;
        else if(s == "l") {
            pos--;
            if(pos < 0) pos += len;
        } else if(s == "r") {
            pos++;
            if(pos >= len) pos -= len;
        } else if(s == "w") {
            cout << t[pos];
        }
    }
    return 0;
}
