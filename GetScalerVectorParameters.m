function [N1 P N C Wf] = GetScalerVectorParameters()

persistent ndata
persistent k firstRun



if isempty(firstRun)
    load data
    k = 1;
    firstRun = 1;
end

N1 = ndata(k);
P =  ndata(k);
N =  ndata(k);
C =  ndata(k);
Wf = ndata(k);


k = k + 1;


