-- flow for recuiters

-- 1. create candidate
INSERT  INTO Candidate
        ( Fname ,
          Lname ,
          address1 ,
          address2 ,
          city ,
          state ,
          zip ,
          email ,
          phonePrimary ,
          phoneSecondary
        )
VALUES  ( '' ,
          '' ,
          '' ,
          '' ,
          '' ,
          '' ,
          0 ,
          '' ,
          '' ,
          '' 
        )
        
        
 -- 2. create position
 
INSERT  INTO Position
        ( reqNumber ,
          positionName ,
          positionDesc ,
          recruiterID ,
          primarySkillID ,
          primarySkillLevel ,
          secondarySkillID ,
          secondarySkillLevel
         
        )
VALUES  ( '' ,
          '' ,
          '' ,
          0 ,
          0 ,
          0 ,
          0 ,
          0 
         
        )       
         
         go 
         
         
 -- 3. request a screening

DECLARE @fname VARCHAR(25) = 'Chandra'
DECLARE @lname VARCHAR(25) = 'Kimpkin'
SELECT  *
FROM    Candidate
WHERE   Lname LIKE @lname
        OR Fname LIKE @fname
go
 
-- use candidate id to create a list of user to choose from then put into screening

DECLARE @reqID INT = 123
DECLARE @positionName VARCHAR(25) = 'SQL DBA'
SELECT  *
FROM    Position
WHERE   reqNumber = 123
        OR positionName = @positionName

-- use position id to create a list of user to choose from then put into screening
 
INSERT  INTO Screening
        ( dateStart ,
          dateEnd ,
          positionID ,
          screenerID ,
          candidateID ,
          specialInstructions ,
          screeningStatusID ,
          isRecommended ,
          screenerComments
        )
VALUES  ( '2013-07-15 01:27:38' ,
          '2013-07-15 01:27:38' ,
          1 ,
          1 ,
          1 ,
          '' ,
          1 ,
          NULL ,
          'notes' 
        )
  -- AND send email TO admin  
  
  
  -- recruiter, my screenings
  
DECLARE @myRecruiterID INT = 1
  
SELECT  p.reqNumber ,
        p.positionName ,
        c.Fname ,
        c.Lname ,
        CONVERT(CHAR(10),s.dateStart,101) + SUBSTRING(CONVERT(varchar,s.dateStart,0),12,8)AS startDate,
          --– mm/dd/yyyy - 10/02/2008  ,
        ss.statusDescription AS [Status], 
        s.isRecommended
FROM    Position p
        JOIN Screening s ON p.ID = s.positionID
        JOIN ScreeningStatus ss ON s.screeningStatusID = ss.ID
        JOIN Candidate c ON s.candidateID = c.ID
WHERE   recruiterID = 1
  
  