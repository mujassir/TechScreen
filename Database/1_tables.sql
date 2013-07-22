

CREATE TABLE dbo.TopLevelClient
    (
      ID INT NOT NULL
             IDENTITY ,
      clientname VARCHAR(50) NULL ,
      address1 VARCHAR(50) NULL ,
      address2 VARCHAR(50) NULL ,
      city VARCHAR(50) NULL ,
      state VARCHAR(2) NULL ,
      zip INT NULL ,
      contactFName VARCHAR(50) NULL ,
      contactLName VARCHAR(50) NULL ,
      email VARCHAR(50) ,
      phonePrimary VARCHAR(10) NULL ,
      phoneSecondary VARCHAR(10) NULL
    ) 
GO
ALTER TABLE dbo.TopLevelClient ADD CONSTRAINT PK_TopLevelClient PRIMARY KEY CLUSTERED  (ID) 
GO




CREATE TABLE dbo.Client
    (
      ID INT NOT NULL
             IDENTITY ,
      clientname VARCHAR(50) NULL ,
      address1 VARCHAR(50) NULL ,
      address2 VARCHAR(50) NULL ,
      city VARCHAR(50) NULL ,
      state VARCHAR(2) NULL ,
      zip INT NULL ,
      contactFName VARCHAR(50) NULL ,
      contactLName VARCHAR(50) NULL ,
      email VARCHAR(50) ,
      phonePrimary VARCHAR(10) NULL ,
      phoneSecondary VARCHAR(10) NULL ,
      toplevelclientID INT
    ) 
GO
ALTER TABLE dbo.Client ADD CONSTRAINT PK_Client PRIMARY KEY CLUSTERED  (ID) 
GO


ALTER TABLE dbo.Client ADD CONSTRAINT
FK_Client_toplevelclientID FOREIGN KEY
(
toplevelclientID
) REFERENCES dbo.TopLevelClient 
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Client_toplevelclientID] ON [dbo].Client (toplevelclientID) WITH (FILLFACTOR=85)
GO





CREATE TABLE dbo.Screener
    (
      ID INT NOT NULL
             IDENTITY ,
      Fname VARCHAR(50) NULL ,
      Lname VARCHAR(50) NULL ,
      address1 VARCHAR(50) NULL ,
      address2 VARCHAR(50) NULL ,
      city VARCHAR(50) NULL ,
      state VARCHAR(2) NULL ,
      zip INT NULL ,
      email VARCHAR(50) ,
      phonePrimary VARCHAR(10) NULL ,
      phoneSecondary VARCHAR(10) NULL
    ) 
GO
ALTER TABLE dbo.Screener ADD CONSTRAINT PK_Screener PRIMARY KEY CLUSTERED  (ID) 
GO




CREATE TABLE dbo.Candidate
    (
      ID INT NOT NULL
             IDENTITY ,
      Fname VARCHAR(50) NULL ,
      Lname VARCHAR(50) NULL ,
      address1 VARCHAR(50) NULL ,
      address2 VARCHAR(50) NULL ,
      city VARCHAR(50) NULL ,
      state VARCHAR(2) NULL ,
      zip INT NULL ,
      email VARCHAR(50) ,
      phonePrimary VARCHAR(10) NULL ,
      phoneSecondary VARCHAR(10) NULL
    ) 
GO
ALTER TABLE dbo.Candidate ADD CONSTRAINT PK_Candidate PRIMARY KEY CLUSTERED  (ID) 
GO




CREATE TABLE dbo.Recruiter
    (
      ID INT NOT NULL
             IDENTITY ,
      Fname VARCHAR(50) NULL ,
      Lname VARCHAR(50) NULL ,
      email VARCHAR(50) ,
      phonePrimary VARCHAR(10) NULL ,
      phoneSecondary VARCHAR(10) NULL ,
      toplevelclientID INT
    ) 
GO
ALTER TABLE dbo.Recruiter ADD CONSTRAINT PK_Recruiter PRIMARY KEY CLUSTERED  (ID) 
GO



ALTER TABLE Recruiter ADD CONSTRAINT
FK_Recruiter_toplevelclientID FOREIGN KEY
(
toplevelclientID
) REFERENCES dbo.TopLevelClient 
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Recruiter_toplevelclientID] ON [dbo].Recruiter (toplevelclientID) WITH (FILLFACTOR=85)
GO



INSERT  INTO [TopLevelClient]
        ( [clientname] ,
          [address1] ,
          [address2] ,
          [city] ,
          [state] ,
          [zip] ,
          [contactFName] ,
          [contactLName] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary]
        )
VALUES  ( 'SMCI' , -- clientname - varchar(50)
          '101 Jamboree Rd' , -- address1 - varchar(50)
          'Ste 500' , -- address2 - varchar(50)
          'Irvine' , -- city - varchar(50)
          'CA' , -- state - varchar(2)
          92656 , -- zip - int
          'Tammy' , -- contactFName - varchar(50)
          'Hawkins' , -- contactLName - varchar(50)
          'thawkins@dummy.com' , -- email - varchar(50)
          '949111222' , -- phonePrimary - varchar(10)
          ''  -- phoneSecondary - varchar(10)
        )
        
INSERT  INTO [Client]
        ( [clientname] ,
          [address1] ,
          [address2] ,
          [city] ,
          [state] ,
          [zip] ,
          [contactFName] ,
          [contactLName] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary] ,
          toplevelclientID
        )
VALUES  ( 'First American Title' , -- clientname - varchar(50)
          '5 6th St' , -- address1 - varchar(50)
          '' , -- address2 - varchar(50)
          'Santa Ana' , -- city - varchar(50)
          'CA' , -- state - varchar(2)
          92666 , -- zip - int
          '' , -- contactFName - varchar(50)
          '' , -- contactLName - varchar(50)
          '' , -- email - varchar(50)
          '' , -- phonePrimary - varchar(10)
          '' , -- phoneSecondary - varchar(10)
          1
        )        
        
        
INSERT  INTO [Client]
        ( [clientname] ,
          [address1] ,
          [address2] ,
          [city] ,
          [state] ,
          [zip] ,
          [contactFName] ,
          [contactLName] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary] ,
          toplevelclientID
        )
VALUES  ( 'GE' , -- clientname - varchar(50)
          '100 Steer St' , -- address1 - varchar(50)
          '' , -- address2 - varchar(50)
          'Houston' , -- city - varchar(50)
          'TX' , -- state - varchar(2)
          65855 , -- zip - int
          '' , -- contactFName - varchar(50)
          '' , -- contactLName - varchar(50)
          '' , -- email - varchar(50)
          '' , -- phonePrimary - varchar(10)
          '' , -- phoneSecondary - varchar(10)
          1
        )    
        
        
        
INSERT  INTO [Recruiter]
        ( [Fname] ,
          [Lname] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary]
                
        )
VALUES  ( 'Jaime' , -- Fname - varchar(50)
          'Jones' , -- Lname - varchar(50)
          'jjones@dummy.com' , -- email - varchar(50)
          '6584442222' , -- phonePrimary - varchar(10)
          ''  -- phoneSecondary - varchar(10)
                
        )        
                
                
INSERT  INTO [Recruiter]
        ( [Fname] ,
          [Lname] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary]
                
        )
VALUES  ( 'Sarah' , -- Fname - varchar(50)
          'Brown' , -- Lname - varchar(50)
          'sbrown@dummy.com' , -- email - varchar(50)
          '3335856666' , -- phonePrimary - varchar(10)
          ''  -- phoneSecondary - varchar(10)
                
        )  
                
                
                
INSERT  INTO [Screener]
        ( [Fname] ,
          [Lname] ,
          [address1] ,
          [address2] ,
          [city] ,
          [state] ,
          [zip] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary]
                        
        )
VALUES  ( 'Nathan' , -- Fname - varchar(50)
          'Jaskot' , -- Lname - varchar(50)
          '9131 Main St' , -- address1 - varchar(50)
          '' , -- address2 - varchar(50)
          'Corona' , -- city - varchar(50)
          'CA' , -- state - varchar(2)
          92883 , -- zip - int
          'njaskot@dummy.com' , -- email - varchar(50)
          '9512223333' , -- phonePrimary - varchar(10)
          ''  -- phoneSecondary - varchar(10)
                        
        )
        
        
INSERT  INTO [Screener]
        ( [Fname] ,
          [Lname] ,
          [address1] ,
          [address2] ,
          [city] ,
          [state] ,
          [zip] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary]
                
        )
VALUES  ( 'Matt' , -- Fname - varchar(50)
          'Monroe' , -- Lname - varchar(50)
          '555 Oak' , -- address1 - varchar(50)
          'Apt #95' , -- address2 - varchar(50)
          'Ventura' , -- city - varchar(50)
          'CA' , -- state - varchar(2)
          91235 , -- zip - int
          'mmonroe@dummy.com' , -- email - varchar(50)
          '8186669999' , -- phonePrimary - varchar(10)
          ''  -- phoneSecondary - varchar(10)
                
        )
                   
                   
INSERT  INTO [Screener]
        ( [Fname] ,
          [Lname] ,
          [address1] ,
          [address2] ,
          [city] ,
          [state] ,
          [zip] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary]
                           
        )
VALUES  ( 'Jose' , -- Fname - varchar(50)
          'Cervantes' , -- Lname - varchar(50)
          '1010 Center Dr.' , -- address1 - varchar(50)
          '' , -- address2 - varchar(50)
          'Lake Elsinore' , -- city - varchar(50)
          'CA' , -- state - varchar(2)
          93223 , -- zip - int
          'jcervantes@dummy.com' , -- email - varchar(50)
          '9517774444' , -- phonePrimary - varchar(10)
          ''  -- phoneSecondary - varchar(10)
                           
        )     
                        
                        
INSERT  INTO [Candidate]
        ( [Fname] ,
          [Lname] ,
          [address1] ,
          [address2] ,
          [city] ,
          [state] ,
          [zip] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary]
                                
        )
VALUES  ( 'Chandra' , -- Fname - varchar(50)
          'Kimpkin' , -- Lname - varchar(50)
          '123 Hanover' , -- address1 - varchar(50)
          '' , -- address2 - varchar(50)
          'Streamwood' , -- city - varchar(50)
          'IL' , -- state - varchar(2)
          60607 , -- zip - int
          'ckimpkin@dummy.com' , -- email - varchar(50)
          '6309685555' , -- phonePrimary - varchar(10)
          ''  -- phoneSecondary - varchar(10)
                                
        )
                                
INSERT  INTO [Candidate]
        ( [Fname] ,
          [Lname] ,
          [address1] ,
          [address2] ,
          [city] ,
          [state] ,
          [zip] ,
          [email] ,
          [phonePrimary] ,
          [phoneSecondary]
                                        
        )
VALUES  ( 'Paul' , -- Fname - varchar(50)
          'Marman' , -- Lname - varchar(50)
          '68 Universal Dr' , -- address1 - varchar(50)
          '' , -- address2 - varchar(50)
          'Universal Cit' , -- city - varchar(50)
          'CA' , -- state - varchar(2)
          92618 , -- zip - int
          'pmarman@dummy.com' , -- email - varchar(50)
          '656857432' , -- phonePrimary - varchar(10)
          ''  -- phoneSecondary - varchar(10)
                                        
        )
                        
                        
                        /*
                        -- screeningAppointment
                        ID,
                        dateStart
                        dateEnd
                        Category
                        Level
                        PoistionID?
                        
                        */

 

 
    
CREATE TABLE Skill
    (
      ID INT PRIMARY KEY
             IDENTITY ,
      skillName VARCHAR(50),

    ) 

INSERT  INTO Skill
        ( skillName )
VALUES  ( 'NONE'  -- skillName - varchar(50)
          )   
 GO

INSERT  INTO Skill
        ( skillName )
VALUES  ( 'SQL DBA'  -- skillName - varchar(50)
          )   
 GO
 
INSERT  INTO Skill
        ( skillName )
VALUES  ( 'SQL Developer'  -- skillName - varchar(50)
          )   
 GO         
 
INSERT  INTO Skill
        ( skillName )
VALUES  ( 'C#'  -- skillName - varchar(50)
          )   
 GO



CREATE TABLE Question
    (
      ID INT PRIMARY KEY
             IDENTITY ,
      questionText VARCHAR(500) ,
      skillID INT ,
      skilllevel INT
    )
    
    
ALTER TABLE Question ADD CONSTRAINT
FK_Question_skillID FOREIGN KEY
(
skillID
) REFERENCES dbo.Skill 
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Question_skillID] ON [dbo].Question (skillID) WITH (FILLFACTOR=85)
GO    

INSERT  INTO Question
        ( questionText, skillID, skilllevel )
VALUES  ( 'What does SQL stand for? ', -- questionText - varchar(500)
          1, -- skillID - int
          1  -- skilllevel - int
          )
          
INSERT  INTO Question
        ( questionText ,
          skillID ,
          skilllevel 
        )
VALUES  ( 'What type of backups are there in SQL server? ' , -- questionText - varchar(500)
          1 , -- skillID - int
          1  -- skilllevel - int
          
        )  
          
INSERT  INTO Question
        ( questionText, skillID, skilllevel )
VALUES  ( 'Name the types of joins? ', -- questionText - varchar(500)
          2, -- skillID - int
          1  -- skilllevel - int
          )                        
 
CREATE TABLE Position
    (
      ID INT PRIMARY KEY
             IDENTITY ,
      reqNumber VARCHAR(100) ,
      positionName VARCHAR(50) ,
      positionDesc VARCHAR(1000) ,
      recruiterID INT ,
      primarySkillID INT ,
      primarySkillLevel INT ,
      secondarySkillID INT ,
      secondarySkillLevel INT,
   
    )
    
    
    
ALTER TABLE Position ADD CONSTRAINT
FK_Position_primarySkillID FOREIGN KEY
(
primarySkillID
) REFERENCES dbo.Skill 
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Position_primarySkillID] ON Position (primarySkillID) WITH (FILLFACTOR=85)
GO 

ALTER TABLE Position ADD CONSTRAINT
FK_Position_SecondarySkillID FOREIGN KEY
(
secondarySkillID
) REFERENCES dbo.Skill 
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Position_SecondarySkillID] ON Position (secondarySkillID) WITH (FILLFACTOR=85)
GO       
    
INSERT  INTO Position
        ( positionName ,
          positionDesc ,
          recruiterID ,
          primarySkillID ,
          primarySkillLevel ,
          secondarySkillID ,
          secondarySkillLevel
        )
VALUES  ( 'SQL DBA' , -- positionName - varchar(50)
          'SQL Database Admin' , -- positionDesc - varchar(1000)
          1 , -- recruiterID - int
          2 , -- primarySkillID - int
          1 , -- primarySkillLevel - int
          3 , -- secondarySkillID - int
          1  -- secondarySkillLevel - int
        )    
CREATE TABLE ScreeningStatus
    (
      ID INT PRIMARY KEY
             IDENTITY ,
      statusDescription VARCHAR(25)
    )       
    
    
INSERT  INTO ScreeningStatus
        ( statusDescription )
VALUES  ( 'Requested' );
    
INSERT  INTO ScreeningStatus
        ( statusDescription )
VALUES  ( 'Confirmed' );
    
INSERT  INTO ScreeningStatus
        ( statusDescription )
VALUES  ( 'Completed' );
  
  
      
CREATE TABLE Screening
    (
      ID INT PRIMARY KEY
             IDENTITY ,
      dateStart DATETIME ,
      dateEnd DATETIME ,
      positionID INT ,
      screenerID INT ,
      candidateID INT ,
      specialInstructions VARCHAR(1000) ,
      screeningStatusID INT ,
      isRecommended BIT ,
      screenerComments VARCHAR(1000)
    )
    
ALTER TABLE Screening ADD CONSTRAINT
FK_Screening_positionID FOREIGN KEY
(
positionID
) REFERENCES Position
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Screening_positionID] ON Screening (positionID) WITH (FILLFACTOR=85)
GO          
    
    
ALTER TABLE Screening ADD CONSTRAINT
FK_Screening_screenerID FOREIGN KEY
(
screenerID
) REFERENCES Screener
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Screening_screenerID] ON Screening (screenerID) WITH (FILLFACTOR=85)
GO          
    
ALTER TABLE Screening ADD CONSTRAINT
FK_Screening_candidateID FOREIGN KEY
(
candidateID
) REFERENCES Candidate
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Screening_candidateID] ON Screening (candidateID) WITH (FILLFACTOR=85)
GO          
        

ALTER TABLE Screening ADD CONSTRAINT
FK_Screening_ScreeningStatusID FOREIGN KEY
(
screeningStatusID
) REFERENCES ScreeningStatus
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_Screening_ScreeningStatusID] ON Screening (screeningStatusID) WITH (FILLFACTOR=85)
GO       
        
INSERT  INTO Screening
        ( dateStart ,
          dateEnd ,
          positionID ,
          screenerID ,
          candidateID
            
        )
VALUES  ( '2013-07-15 08:00:00' , -- dateStart - datetime
          '2013-07-15 08:30:00' , -- dateEnd - datetime
          1 , -- positionID - int
          1 , -- screenerID - int
          1  -- candidateID - int
            
        )
         
         
         
CREATE TABLE ScreenerSkillxRef
    (
      ID INT PRIMARY KEY
             IDENTITY ,
      screenerID INT ,
      skillID INT
    )

ALTER TABLE ScreenerSkillxRef ADD CONSTRAINT
FK_ScreenerSkillxRef_screenerID FOREIGN KEY
(
screenerID
) REFERENCES Screener
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_ScreenerSkillxRef_screenerID] ON ScreenerSkillxRef (screenerID) WITH (FILLFACTOR=85)
GO   


ALTER TABLE ScreenerSkillxRef ADD CONSTRAINT
FK_ScreenerSkillxRef_skillID FOREIGN KEY
(
skillID
) REFERENCES Skill
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_ScreenerSkillxRef_skillID] ON ScreenerSkillxRef (skillID) WITH (FILLFACTOR=85)
GO   


INSERT  INTO ScreenerSkillxRef
        ( screenerID, skillID )
VALUES  ( 1, -- screenerID - int
          1  -- skillID - int
          )
          
          
INSERT  INTO ScreenerSkillxRef
        ( screenerID, skillID )
VALUES  ( 1, -- screenerID - int
          2  -- skillID - int
          )
  
INSERT  INTO ScreenerSkillxRef
        ( screenerID, skillID )
VALUES  ( 1, -- screenerID - int
          3  -- skillID - int
          )
  
  
CREATE TABLE AnswerStatus
    (
      ID INT PRIMARY KEY
             IDENTITY ,
      statusDescription VARCHAR(25)
    )       
    
    
INSERT  INTO AnswerStatus
        ( statusDescription )
VALUES  ( 'Not yet completed' );
    
INSERT  INTO AnswerStatus
        ( statusDescription )
VALUES  ( 'Correct' );
    
INSERT  INTO AnswerStatus
        ( statusDescription )
VALUES  ( 'Incorrect' );
  
CREATE TABLE ScreeningQA
    (
      ID INT PRIMARY KEY
             IDENTITY ,
      screeningID INT ,
      questionID INT ,
      screenerNotes VARCHAR(250) ,
      candidateID INT ,
      answerStatusID INT -- 1 = not yet answered, 2 = correct, 3 incorrect 
    )
    
    
ALTER TABLE ScreeningQA ADD CONSTRAINT
FK_ScreeningQA_screeningID FOREIGN KEY
(
screeningID
) REFERENCES Screening
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_ScreeningQA_screeningID] ON ScreeningQA (screeningID) WITH (FILLFACTOR=85)
GO   



ALTER TABLE ScreeningQA ADD CONSTRAINT
FK_ScreeningQA_questionID FOREIGN KEY
(
questionID
) REFERENCES Question
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_ScreeningQA_questionID] ON ScreeningQA (questionID) WITH (FILLFACTOR=85)
GO   

---
ALTER TABLE ScreeningQA ADD CONSTRAINT
FK_ScreeningQA_answerStatusID FOREIGN KEY
(
answerStatusID
) REFERENCES AnswerStatus
(
ID
) ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
	
GO

CREATE NONCLUSTERED INDEX [idx_FK_ScreeningQA_answerStatusID] ON ScreeningQA (answerStatusID) WITH (FILLFACTOR=85)
GO   
---
INSERT  INTO ScreeningQA
        ( screeningID ,
          questionID ,
          screenerNotes ,
          candidateID ,
          answerStatusID
        )
VALUES  ( 1 ,
          1 ,
          'my notes' ,
          1 ,
          1 
        )
        
        
        