static double pow10[11] = {
        1, 0.1, 0.01, 0.001, 0.0001,
        0.00001, 0.000001, 0.0000001, 0.00000001, 0.000000001, 0.0000000001};
double function(double x) {
    return x * x * x - x * x * 0.5 + x * 0.2 - 4;
}

double find_zero(int precision) {
    double l = 1, r = 3;
    double step = pow10[precision + 1];
    while (r - l > step) {
        double m = (r + l) / 2;
        if (function(m) < 0) {
            l = m;
        } else {
            r = m;
        }
    }
    return r;
}
