function N = GetDIN()

persistent a
persistent gt
persistent KN
persistent r
persistent kf
persistent b
persistent p


N = (((a*gt*p/N+KN)-kf)*N) + b*p;


