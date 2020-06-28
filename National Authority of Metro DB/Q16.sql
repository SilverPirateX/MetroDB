SELECT S.Fname,S.Lname
FROM staff AS S
WHERE s.Ssn IN ( SELECT S.ssn

FROM dependant AS D
WHERE S.Fname=D.Name) ;