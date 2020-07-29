function N1 = GetOrgN()

persistent KN1
persistent kf
persistent fpn
persistent vs
persistent h
persistent fON
persistent anp
persistent r
persistent dp
persistent WN1
persistent n1


N1 = -(KN1+kf+fpn(vs/h))*n1 + (fON*anp*(r+dp))*p + (WN1/h);






