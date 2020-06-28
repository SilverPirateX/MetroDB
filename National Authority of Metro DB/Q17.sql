select M.M_ssn,M.type,S.Number,S.Name
from manager M inner join station S on M.M_Ssn=S.Manager_M_Ssn;
