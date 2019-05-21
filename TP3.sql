-- 1.
select  CAT as 'Catégorie',
        sum(client.COMPTE) as 'Somme', 
        avg(client.COMPTE) as 'Moyenne', 
        count(*) as 'Nombre'
from dbo.CLIENT client
group by client.CAT

-- 2.
select  client.CAT as 'Catégorie',
        client.LOCALITE as 'Localité',
        sum(client.COMPTE) as 'Somme', 
        avg(client.COMPTE) as 'Moyenne', 
        count(*) as 'Nombre'
from dbo.CLIENT client
group by client.CAT, client.LOCALITE

-- 3.
select  client.NCLI as 'N Client', 
        client.NOM as 'Nom Client', 
        IsNull(sum(produit.PRIX * detail.QCOM), 0) as 'Total'
from dbo.CLIENT client
left join dbo.COMMANDE commande
    on commande.NCLI = client.NCLI
left join dbo.DETAIL detail
    on commande.NCOM = detail.NCOM
left join dbo.PRODUIT produit
    on produit.NPRO = detail.NPRO
group by client.NCLI, client.NOM

-- 4.
select sum(produit.QSTOCK * detail.QCOM) as 'Total commande par jour'
from    dbo.COMMANDE commande,
        dbo.PRODUIT produit,
        dbo.DETAIL detail
where
    commande.NCOM = detail.NCOM AND
    detail.NPRO = produit.NPRO
group by commande.DATECOM

-- 5.
select  produit.NPRO as 'Numéro',
        count(*) as 'Count'
from dbo.PRODUIT produit
group by produit.NPRO
having count(*) >= 2

-- 6.
select  client.LOCALITE as 'Localite',
        IsNull(sum(produit.PRIX * detail.QCOM), 0) as 'Total'
from dbo.CLIENT client
left join dbo.COMMANDE commande
    on commande.NCLI = client.NCLI
left join dbo.DETAIL detail
    on commande.NCOM = detail.NCOM
left join dbo.PRODUIT produit
    on produit.NPRO = detail.NPRO
group by client.LOCALITE

-- 7.
select  client.LOCALITE as 'Localité',
        client.CAT as 'Catégorie',
        IsNull(sum(produit.PRIX * detail.QCOM), 0) as 'Total'
from    dbo.COMMANDE commande,
        dbo.CLIENT client,
        dbo.DETAIL detail,
        dbo.PRODUIT produit
where
        produit.NPRO = detail.NPRO AND
        detail.NCOM = commande.NCOM AND
        commande.NCLI = client.NCLI
group by client.LOCALITE, client.CAT

-- 8.
select  client.NOM as 'Nom',
        count(distinct commande.NCOM) as 'N Commande', 
        count(distinct produit.NPRO) as 'N Produit', 
        count(*) as 'N Detail'
FROM    dbo.CLIENT client,
        dbo.COMMANDE commande,
        dbo.DETAIL detail,
        dbo.PRODUIT produit
WHERE   client.NCLI = commande.NCLI AND
        commande.NCOM = detail.NCOM AND
        detail.NPRO = produit.NPRO
GROUP BY
        client.NCLI, client.NOM

-- 9.
select  client.LOCALITE as 'Localite',
        client.CAT as 'Categorie', 
        count(distinct commande.NCOM) as 'Nombre commande',
        sum(detail.QCOM * produit.PRIX) as 'Total'
FROM    dbo.CLIENT client,
        dbo.COMMANDE commande,
        dbo.DETAIL detail,
        dbo.PRODUIT produit
WHERE   client.NCLI = commande.NCLI AND
        commande.NCOM = detail.NCOM AND
        detail.NPRO = produit.NPRO
group by client.LOCALITE, client.CAT

-- 10.
select produit.LIBELLE
FROM    dbo.CLIENT client,
        dbo.COMMANDE commande,
        dbo.DETAIL detail,
        dbo.PRODUIT produit
WHERE   client.NCLI = commande.NCLI AND
        commande.NCOM = detail.NCOM AND
        detail.NPRO = produit.NPRO
group by client.LOCALITE, produit.LIBELLE
having count(client.LOCALITE) >= 2

-- 11.
select produit.LIBELLE, client.LOCALITE
FROM    dbo.CLIENT client,
        dbo.COMMANDE commande,
        dbo.DETAIL detail,
        dbo.PRODUIT produit
WHERE   client.NCLI = commande.NCLI AND
        commande.NCOM = detail.NCOM AND
        detail.NPRO = produit.NPRO
group by client.LOCALITE, produit.LIBELLE
having sum(detail.QCOM) >= 500
        
-- 12.
select  client.LOCALITE,
        client.CAT,
        produit.LIBELLE
FROM    dbo.CLIENT client,
        dbo.COMMANDE commande,
        dbo.DETAIL detail,
        dbo.PRODUIT produit
WHERE   client.NCLI = commande.NCLI AND
        commande.NCOM = detail.NCOM AND
        detail.NPRO = produit.NPRO AND
        produit.LIBELLE like '%SAPIN%' AND
        client.CAT = 'C1'
group by client.LOCALITE, produit.LIBELLE, client.CAT