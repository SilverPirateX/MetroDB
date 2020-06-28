select Lname as 'last name' ,Fname as 'first name' ,salary,ssn
from staff S 
where salary > all(
select salary 
from staff S 
where Ssn= 987654328 );