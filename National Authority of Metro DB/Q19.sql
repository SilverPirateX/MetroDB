(select distinct station_number
from employee
where staff_Ssn=987654322)
union
(select distinct station_number
from employee
where place='IT');