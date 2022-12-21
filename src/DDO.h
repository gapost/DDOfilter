#ifndef _DDO_H_
#define _DDO_H_

#include <cmath>

#define INVSQRT2 0.7071067811865475

template< typename T >
class DDO {
    // state
    T x_[2];
    // G = e^{A*t}
    T G_[4];
    // h = int(G,t',0,t)*[0; 1]
    T h_[2];
    // vars
    T dt_, z_;
    // set up filter coeffs
    void init_() {
        T q, c, s;
        c = s = std::exp(-z_*dt_);
        if (z_<T(1)) {
            q = std::sqrt(T(1)-z_*z_);
            c *= std::cos(q*dt_);
            s *= std::sin(q*dt_)/q;
        } else if (z_==T(1)) s *= dt_;
        else { // z>1
            q = std::sqrt(z_*z_-T(1));
            c *= std::cosh(q*dt_);
            s *= std::sinh(q*dt_)/q;
        }  
        G_[0] = c+z_*s;
        G_[1] = s;
        G_[2] = -s;
        G_[3] = c-z_*s; 
        h_[0] = T(1) - c - z_*s;
        h_[1] = s; 
    }
public:
    explicit DDO(const T& dt, const T& z = INVSQRT2) : dt_(dt), z_(z)
    {
        z_ = std::abs(z_);
        init_();
        setState(0,0);
    }
    const T& damping() const { return z_; }
    void setDamping(const T& z) {
        z_ = std::abs(z);
        init_();
    }
    const T& dt() const { return dt_; }
    void setDt(const T& dt) {
        dt_ = dt;
        init_();
    }
    const T& x() const { return x_[0]; }
    const T& dxdt() const { return x_[1]; }
    const T* G() const { return G_; }
    const T* h() const { return h_; }
    void setState(const T& x0, const T& dxdt0) {
        x_[0] = x0;
        x_[1] = dxdt0;
    }
    void update(const T& u)
    {
        T x0 = G_[0]*x_[0] + G_[1]*x_[1] + h_[0]*u;
        T x1 = G_[2]*x_[0] + G_[3]*x_[1] + h_[1]*u;
        x_[0] = x0;
        x_[1] = x1;
    }

};

#endif