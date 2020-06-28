create view sam as(
select Fname,Lname,ssn,A.Number
from  staff S,employee E,station A,ticket_window T 
where S.Ssn=E.staff_Ssn and E.Station_Number=A.Number and A.Number=T.Station_Number and A.number=1
);