
-- copy 历史数据 2006 326114
SELECT COUNT(1) FROM `test`.`stocktransactiondetail` 
WHERE `TransactionDate` >= '2005-12-01' AND `TransactionDate` < '2007-02-01';

INSERT INTO `stock`.`MarketHistory_2006` ( `StockCode`, `MarketDate`, `PreClose`, `Open`, `Close`, `Hign`, `Low`, `Volume`, `Amount` )
SELECT `Code`, `TransactionDate`, -999, `BeginPrice`, `EndPrice`, `HighestPrice`, `LowestPrice`, `Volume`, `TransactionMoney`
FROM `test`.`stocktransactiondetail` 
WHERE `TransactionDate` >= '2005-12-01' AND `TransactionDate` < '2007-02-01';

SELECT COUNT(1) FROM `stock`.`MarketHistory_2006`;

SELECT MIN(`StockCode`), MAX(`StockCode`) FROM `stock`.`MarketHistory_2006` WHERE `StockCode` >= '600000';

UPDATE `stock`.`MarketHistory_2006`
SET `StockCode` = CONCAT('sh', `StockCode` )
WHERE `StockCode` >= '600000';

SELECT MIN(`StockCode`), MAX(`StockCode`) FROM `stock`.`MarketHistory_2006` WHERE `StockCode` < '600000';

UPDATE `stock`.`MarketHistory_2006`
SET `StockCode` = CONCAT('sz', `StockCode` )
WHERE `StockCode` < '600000';

SELECT MIN(`StockCode`), MAX(`StockCode`) FROM `stock`.`MarketHistory_2006`;

-- 398451
SELECT COUNT(1) FROM `stock`.`MarketHistory_2006`;

SELECT MIN(`MarketDate`), MAX(`MarketDate`) FROM `stock`.`MarketHistory_2006`;

-- 查询结果 1360
SELECT DISTINCT(`StockCode`) FROM `stock`.`MarketHistory_2006`;
SELECT COUNT(1) FROM ( SELECT DISTINCT(`StockCode`) FROM `stock`.`MarketHistory_2006` ) AS T;

-- 更新 PreClose / PreVolume spend 67 seconds
SELECT `StockCode`, `MarketDate`, `Close`, `PreClose`, `Volume`, `PreVolume`, `Rate`, `PreRate`, `VolumeRate` 
FROM `stock`.`MarketHistory_2006` WHERE `StockCode` = 'sz000678' 
ORDER BY `MarketDate`;

SELECT COUNT(1) FROM `stock`.`MarketHistory_2006` WHERE `PreClose` = -999;

-- 更新 Rate
SELECT COUNT(1) FROM `stock`.`MarketHistory_2006` WHERE `Rate` IS NULL;

UPDATE `stock`.`MarketHistory_2006` 
SET `Rate` = `Close` / `PreClose` 
WHERE `PreClose` != -999;

-- 更新 VolumeRate
SELECT COUNT(1) FROM `stock`.`MarketHistory_2006` WHERE `VolumeRate` IS NULL;

UPDATE `stock`.`MarketHistory_2006` 
SET `VolumeRate` = `Volume` / `PreVolume` 
WHERE `VolumeRate` IS NULL AND `PreVolume` IS NOT NULL;

-- 2720 spend 80 seconds
SELECT COUNT(1) FROM `stock`.`MarketHistory_2006` WHERE `PreRate` IS NULL;

-- 历史纪录的天数 283
SELECT COUNT(1) FROM ( SELECT DISTINCT(`MarketDate`) FROM `stock`.`MarketHistory_2006` ) AS T;

-- 历史纪录中有效的天数 281
SELECT DISTINCT(`MarketDate`)
FROM `stock`.`MarketHistory_2006` 
WHERE `PreRate` < 1 AND `Rate` > 1 AND `VolumeRate` > 1
ORDER BY `MarketDate`;

SELECT COUNT(1) FROM (
SELECT DISTINCT(`MarketDate`)
FROM `stock`.`MarketHistory_2006` 
WHERE `PreRate` < 1 AND `Rate` > 1 AND `VolumeRate` > 1
ORDER BY `MarketDate`
) AS T;

SELECT `StockCode`, `MarketDate`, `Close`, `PreClose`, `Volume`, `PreVolume`, `Rate`, `PreRate`, `VolumeRate` 
FROM `stock`.`MarketHistory_2006` WHERE `StockCode` = 'sz000678' 
ORDER BY `MarketDate`;

-- 历史纪录中有效的天数 1405 5X
SELECT COUNT(1) FROM `stock`.`nanhuacrabstore_2006`;

-- 2666
SELECT * FROM `stock`.`stock`;
SELECT COUNT(1) FROM `stock`.`stock`;

SELECT * FROM ( SELECT DISTINCT(`StockCode`) FROM `stock`.`MarketHistory_2006` ) AS t1
WHERE t1.`StockCode` NOT IN ( SELECT `StockCode` FROM `stock` );

-- 历史纪录中有效的天数 1425 10+
SELECT * FROM (
SELECT DISTINCT(`MarketDate`) FROM `stock`.`MarketHistory_2006` ) AS t1
WHERE t1.`MarketDate` NOT IN ( SELECT DISTINCT( `FocusDate` ) FROM `stock`.`nanhuacrabstore_2006` );

SELECT COUNT(1) * 5 FROM (
SELECT DISTINCT(`MarketDate`) FROM `stock`.`MarketHistory_2006` ) AS t1
WHERE t1.`MarketDate` NOT IN ( SELECT DISTINCT( `FocusDate` ) FROM `stock`.`nanhuacrabstore_2006` );

SELECT `StockCode`, `MarketDate`, `Close`, `PreClose`, `Volume`, `PreVolume`, `Rate`, `PreRate`, `VolumeRate` 
FROM `stock`.`MarketHistory_2006`
WHERE `Rate` > 1 AND `VolumeRate` > 1 AND `MarketDate` = '2008-11-17';

SELECT `MarketHistory`.`StockCode`, `Stock`.`StockName`, `Stock`.`Industry`, `MarketDate`, `PreClose`, `Close`, `Open`, `Low`, `Hign`, `VolumeRate`
FROM `MarketHistory` INNER JOIN `Stock` ON `MarketHistory`.`StockCode` = `Stock`.`StockCode`
WHERE `PreRate` < 1 AND `Rate` > 1 AND `VolumeRate` > 1
AND `MarketDate` = '2008-09-23' AND `MarketHistory`.`StockCode` NOT LIKE 'sz3%'
ORDER BY `VolumeRate` DESC, `MarketHistory`.`StockCode`
LIMIT 0, 1;

-- 关注日期 1415 spend 85 seconds
SELECT COUNT(1) FROM `stock`.`nanhuacrabstore_2006`;
SELECT * FROM `stock`.`nanhuacrabstore_2006` ORDER BY `FocusDate` DESC, `StockCode`;
SELECT `focusdate` FROM `stock`.`nanhuacrabstore_2006` GROUP BY `focusdate` HAVING COUNT(1) < 5;

SELECT COUNT(1) * 5 FROM (
SELECT DISTINCT( `MarketDate` ) FROM `stock`.`MarketHistory_2006` ) AS T;

SELECT *, COUNT(1) FROM (
SELECT DISTINCT(`MarketDate`) FROM `markethistory` ) AS t1
WHERE t1.`MarketDate` NOT IN ( SELECT `focusdate` FROM `nanhuacrabstore` );

SELECT * FROM `MarketHistory` WHERE `MarketDate` NOT IN ( SELECT `MarketDate` FROM `nanhuacrabstore` );

-- init spend 38 seconds
-- buy spend 55 seconds
-- sell spend 36 seconds
-- close spend 26 seconds
-- out spend 60 seconds
SELECT `BuyRate`, `SellRate`, COUNT(1), COUNT(`BuyDate`) / COUNT(1), COUNT(`BuyDate`), COUNT(`SellDate`), COUNT(`SellDate`) / COUNT(`BuyDate`), COUNT(`Close`)
FROM `stock`.`nanhuacrabstore_2006` GROUP BY `BuyRate`, `SellRate`;

-- spend 40 seconds
SELECT COUNT(1), COUNT(`Close`) FROM `test`.`nanhuacrabstore`;
SELECT * FROM `nanhuacrabstore` WHERE `Close` IS NULL;
SELECT * FROM `nanhuacrabstore` WHERE `Close` IS NULL;

SELECT * FROM `MarketHistory_2006` WHERE `StockCode` = 'sh600651' ORDER BY `MarketDate` DESC LIMIT 0, 1;















