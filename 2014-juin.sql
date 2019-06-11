USE CLICOM;

-- Question 1.1
-- Return 0 rows
SELECT NCOM, DATECOM FROM dbo.COMMANDE commande
WHERE NCLI IN 
    (SELECT client.NCLI FROM dbo.CLIENT client
    WHERE COMPTE < 0)
AND YEAR(commande.DATECOM) = 2013

-- Question 1.2
-- Return 1 row
-- |  Moyenne des prix  |
-- |--------------------|
-- | 152.500000         |
SELECT AVG(produit.PRIX) as 'Moyenne des prix'
FROM dbo.PRODUIT produit
WHERE produit.NPRO NOT IN
    (SELECT detail.NPRO 
    FROM
        dbo.CLIENT client,
        dbo.COMMANDE commande,
        dbo.DETAIL detail
    WHERE client.NCLI = commande.NCLI
    AND commande.NCOM = detail.NCOM
    AND client.LOCALITE = 'Poitiers'
    AND YEAR(commande.DATECOM) > 2010)
AND produit.LIBELLE like '%SAPIN%'

-- Question 1.3
-- Return 1 row
-- |  NOM       |   Total  |
-- |------------|----------|
-- |  VANDERKA  | 30       |
SELECT client.NOM, sum(detail.QCOM) as 'Total'
FROM 
    dbo.CLIENT client,
    dbo.COMMANDE commande,
    dbo.DETAIL detail,
    dbo.PRODUIT produit
WHERE client.NCLI = commande.NCLI
AND commande.NCOM = detail.NCOM
AND detail.NPRO = produit.NPRO
AND client.LOCALITE = 'Namur'
AND produit.LIBELLE LIKE '%ACIER%'
GROUP BY client.NOM

-- Question 1.4
-- 0 rows affected
UPDATE dbo.CLIENT
SET dbo.CLIENT.CAT = 'A2'
WHERE dbo.CLIENT.NCLI NOT IN 
    (SELECT DISTINCT client.NCLI 
    FROM 
        dbo.CLIENT client,
        dbo.COMMANDE commande
    WHERE client.NCLI = commande.NCLI)
AND dbo.CLIENT.CAT = 'A1'

