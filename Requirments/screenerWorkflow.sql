-- screener workflow

-- screener receives a pending screening

DECLARE @myScreenerID INT = 1
  
SELECT  p.reqNumber ,
        p.positionName ,
        --c.Fname ,
        --c.Lname ,
        CONVERT(CHAR(10), s.dateStart, 101)
        + SUBSTRING(CONVERT(VARCHAR, s.dateStart, 0), 12, 8) AS startDate
          --– mm/dd/yyyy - 10/02/2008  
FROM    Position p
        JOIN Screening s ON p.ID = s.positionID
        JOIN ScreeningStatus ss ON s.screeningStatusID = ss.ID
        JOIN Candidate c ON s.candidateID = c.ID
WHERE   s.screenerID = @myScreenerID       

 -- he can click 'details' to go to new page with details of screening.
DECLARE @myScreenerID INT = 1
  
SELECT  p.reqNumber ,
        p.positionName ,
        c.Fname ,
        c.Lname ,
        c.city ,
        c.state ,
        c.phonePrimary ,
        c.phoneSecondary ,
        p.reqNumber ,
        p.positionName ,
        p.positionDesc ,
        sk1.skillName ,
        p.primarySkillLevel ,
        sk2.skillName ,
        p.secondarySkillLevel ,
        CONVERT(CHAR(10), s.dateStart, 101)
        + SUBSTRING(CONVERT(VARCHAR, s.dateStart, 0), 12, 8) AS startDate
          --– mm/dd/yyyy - 10/02/2008  
FROM    Position p
        JOIN Skill sk1 ON p.primarySkillID = sk1.ID
        JOIN Skill sk2 ON p.secondarySkillID = sk2.ID
        JOIN Screening s ON p.ID = s.positionID
        JOIN ScreeningStatus ss ON s.screeningStatusID = ss.ID
        JOIN Candidate c ON s.candidateID = c.ID
WHERE   s.screenerID = @myScreenerID       

