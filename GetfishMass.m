function Wf = GetfishMass()

persistent b
persistent a
persistent R
persistent k
persistent wf
persistent h
persistent etaf
persistent lambdaf



R = h*lambdaf*etaf


Wf = (b*(1-a)*R)-k*wf;