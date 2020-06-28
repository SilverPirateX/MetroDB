select S.Fname,S.Lname,E.Station_Number,E.Place,E.staff_Ssn,S.Ssn
from staff as S inner join employee as E on
E.staff_Ssn =S.Ssn and E.Station_Number=1;
