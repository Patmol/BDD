USE CLICOM;

-- Question 1.1
-- Return 0 rows
SELECT DISTINCT(client.NOM) 
FROM 
    dbo.CLIENT      client,
    dbo.COMMANDE    commande,
    dbo.DETAIL      detail
WHERE client.NCLI = commande.NCLI
AND commande.NCOM = detail.NCOM
AND detail.NPRO = ALL 
    (SELECT produit.NPRO
    FROM dbo.PRODUIT produit)

-- Question 1.2
-- Return 10 rows
SELECT 
    client.CAT, 
    produit.NPRO, 
    sum(detail.QCOM * produit.PRIX) as 'Commande'
FROM
    dbo.CLIENT client,
    dbo.COMMANDE commande,
    dbo.DETAIL detail,
    dbo.PRODUIT produit
WHERE client.NCLI = commande.NCLI
AND commande.NCOM = detail.NCOM
AND detail.NPRO = produit.NPRO
GROUP BY client.CAT, produit.NPRO

-- Question 1.3
-- Return 1 row
SELECT
    produit.LIBELLE,
    client.LOCALITE,
    detail.QCOM
FROM
    dbo.CLIENT client,
    dbo.COMMANDE commande,
    dbo.DETAIL detail,
    dbo.PRODUIT produit
WHERE client.NCLI = commande.NCLI
AND commande.NCOM = detail.NCOM
AND detail.NPRO = produit.NPRO
GROUP BY produit.LIBELLE, client.LOCALITE, detail.QCOM
HAVING detail.QCOM > 500