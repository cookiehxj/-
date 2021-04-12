任务二：创建数据表并插入测试数据
CREATE TABLE KungFu(
kID INT(11) PRIMARY KEY,
kName VARCHAR(10) NOT NULL,
dID VARCHAR(5) NOT NULL,
kWeapon CHAR(3) NOT NULL,
kPower CHAR(3) NOT NULL,
kComment text not NULL
);

INSERT INTO KungFu(kID,kName,dID,kWeapon,kPower,kComment) VALUES
(1,'打狗棒法',1,'棍','强','丐帮帮主嫡传武学打狗棒法'),
(2,'降龙十八掌',1,'无','强','天下第一刚猛掌法'),
(3,'天罡北斗阵',2,'无','中','是全真教中最上乘的玄门功夫'),
(4,'全真剑法',2,'剑','中','剑法只有三十六招，这三十六招剑法之中'),
(5,'落英神剑掌',3,'无','中','是黄药师从剑法中变法而得'),
(6,'弹指神通',3,'无','强','为黄药师所创'),
(7,'一阳指',4,'无','强','【南帝】一灯大师的专擅指法'),
(8,'一阳书指',4,'判官笔','中','朱子柳所创，由一阳指演变而来');

CREATE TABLE MenKungFu(
skID INT(11) PRIMARY KEY,
sID INT(11) NOT NULL,
kID INT(11) NOT NULL,
skGrade enum('A','B','c','E') NOT NULL
);

INSERT INTO MenKungFu(skID,sID,kID,skGrade) VALUES
(1,1,1,'A'),
(2,6,5,'C'),
(3,4,3,'B'),
(4,7,6,'E'),
(5,8,8,'A'),
(6,6,6,'C');

任务三：创建数据表间的关系及约束
根据物理模型，为表添加外健
ALTER TABLE MenKungFu ADD 
CONSTRAINT fk_sID FOREIGN KEY(sID)
                  REFERENCES Swordsmen(sID);

ALTER TABLE MenKungFu ADD 
CONSTRAINT fk_kID FOREIGN KEY(kID)
                  REFERENCES KungFu(kID);

ALTER TABLE Swordsmen ADD 
CONSTRAINT fk_Date FOREIGN KEY(sEnterDate)
                  REFERENCES Swordsmen(sEnterDate);

ALTER TABLE KungFu ADD 
CONSTRAINT fk_ID FOREIGN KEY(dID)
                  REFERENCES KungFu(dID);

1)查询所有出生地在江南（桃花岛，浙江）的侠客的侠客基本信息
SELECT *
FROM Swordsmen
WHERE sBirthPlace='桃花岛' OR sBirthPlace='浙江';

2)查询所有选修了武功“弹指神通”的侠客的侠客姓名
SELECT sName
FROM Swordsmen JOIN KungFu USING(dID)  
WHERE kName='弹指神通';

3)查询侠客“黄蓉”所选修的武功名称以及修炼等级
SELECT kName,skGrade
FROM Swordsmen JOIN KungFu USING(dID)
               JOIN MenKungFu USING(kID)
WHERE sName='黄蓉';

4)查询所有杀伤力为“强”的武功的武功基本信息
SELECT *
FROM KungFu
WHERE kPower='强';

5)创建视图用于查询侠客所属选修武功，列出侠客姓名，武功名称以及修炼等级
CREATE VIEW view_Kungfu
AS
SELECT sName,kName,skGrade
FROM Swordsmen JOIN KungFu USING(dID)
               JOIN MenKungFu USING(kID);
SELECT *
FROM view_Kungfu;

6)创建存储过程，查询指定武功所使用的武器
CREATE PROCEDURE spGetKunFu(IN name VARCHAR(10))
BEGIN
   SELECT kWeapon
   FROM Kungfu
   WHERE kName=name;
END

CALL spGetKunFu('打狗棒法');


