-- 1.
select 
    SUM(compte) as 'Sum', 
    MIN(compte) as 'Min', 
    AVG(compte) as 'Avg', 
    MAX(compte) as 'Max'
from CLIENT

-- 2.
select distinct LOCALITE from dbo.CLIENT client
inner join dbo.COMMANDE commande
    on client.NCLI = commande.NCLI
where MONTH(commande.DATECOM) = 1 
    and YEAR(commande.DATECOM) = 2016

-- 3.
select distinct NPRO, LIBELLE from dbo.PRODUIT produit
where produit.NPRO not in
    (select detail.NPRO from dbo.DETAIL detail
    where detail.NCOM in
        (select commande.NCOM from dbo.COMMANDE commande
        where commande.NCLI in
            (select client.NCLI from dbo.CLIENT
            where LOCALITE = 'Toulouse')))
and produit.LIBELLE like '%SAPIN%'

-- 4
select produit.NPRO, produit.LIBELLE 
from dbo.PRODUIT produit
where produit.NPRO not in
    (select detail.NPRO from dbo.DETAIL detail
    where detail.NCOM in (
        select commande.NCOM from dbo.COMMANDE commande
        where YEAR(commande.DATECOM) = 2015))

-- 5.
select detail.NPRO, produit.LIBELLE, detail.QCOM * produit.PRIX as 'Total'
from dbo.DETAIL detail, 
    dbo.COMMANDE commande, 
    dbo.PRODUIT produit,
    dbo.CLIENT client
where commande.NCOM = detail.NCOM 
and produit.NPRO = detail.NPRO
and client.NCLI = commande.NCLI
and client.NCLI = 'C400'

-- 6.
select count(distinct commande.NCOM) as 'Commande avec ACIER'
from dbo.COMMANDE commande,
    dbo.DETAIL detail,
    dbo.PRODUIT produit
where commande.NCOM = detail.NCOM
and produit.NPRO = detail.NPRO
and produit.LIBELLE like '%ACIER%'

-- 7.
select sum(detail.QCOM * produit.PRIX) as 'Montant produit sapin'
from dbo.DETAIL detail,
    dbo.PRODUIT produit
where produit.NPRO = detail.NPRO
and produit.LIBELLE like '%SAPIN%' 

-- 8.
create table QUESTION8 (
    NCOM        CHAR(12) NOT NULL,
    DATECOM     DATE NOT NULL,
    QCOM        DECIMAL(8) NOT NULL,
    NPRO        CHAR(15) NOT NULL,
    PRIX        DECIMAL(6) NOT NULL,
    TOTAL       DECIMAL(8) NOT NULL
)

insert into QUESTION8 (NCOM, DATECOM, QCOM, NPRO, PRIX, TOTAL)
(select
    commande.NCOM as 'Numéro commande',
    commande.DATECOM as 'Date commande',
    detail.QCOM as 'Quantité commandée',
    produit.NPRO as 'Numéro produit',
    produit.PRIX as 'Prix produit',
    detail.QCOM * produit.PRIX as 'Montant TOTAL'
from dbo.COMMANDE commande,
    dbo.DETAIL detail,
    dbo.PRODUIT produit
where commande.NCOM = detail.NCOM
and produit.NPRO = detail.NPRO)

-- 9.
select 
    count(distinct NCOM) as 'Nombre commande',
    count(distinct NPRO) as 'Nombre produit commandé',
    count(QCOM) as 'Nombre de détail'
from QUESTION8

-- 10.
select 
    count(commande.NCOM) as 'Nombre commandes', 
    sum(question8.TOTAL) as 'Total commandes'
from dbo.COMMANDE commande,
    dbo.CLIENT client,
    dbo.QUESTION8 question8
where commande.NCLI = client.NCLI
and question8.NCOM = commande.NCOM
and client.LOCALITE = 'Namur'

-- 11.
select COUNT(NPR) from dbo.PRODUIT produit
where produit.NPRO not in
    (select detail.NPRO from dbo.DETAIL detail
    where detail.NCOM in
        (select commande.NCOM from dbo.COMMANDE commande
        where commande.NCLI in
            (select client.NCLI from dbo.CLIENT
            where LOCALITE = 'Namur')
        and YEAR(commande.DATECOM) <= 2015))
and produit.QSTOCK > 100

-- 12.
select commande.NCOM, commande.DATECOM 
from dbo.COMMANDE commande,
    dbo.CLIENT client
where client.NCLI = commande.NCLI
and client.LOCALITE = 'Poitiers'
and client.COMPTE < 0
and YEAR(commande.DATECOM) = 2016

-- 13.
select client.LOCALITE 
from dbo.CLIENT client,
    dbo.COMMANDE commande,
    dbo.PRODUIT produit,
    dbo.DETAIL detail
where client.NCLI = commande.NCLI
and produit.NPRO = detail.NPRO
and commande.NCOM = detail.NCOM
and client.CAT = 'C1'
and produit.LIBELLE like '%SAPIN%'

-- 14.
update dbo.CLIENT
set COMPTE = 0
where CAT = 'C1'

select * from dbo.CLIENT

-- 15.
delete from dbo.CLIENT
where CAT IS NULL 

-- 16.
select distinct client.LOCALITE 
from dbo.CLIENT client,
    dbo.COMMANDE commande,
    dbo.DETAIL detail,
    dbo.PRODUIT produit
where client.NCLI = commande.NCLI
and commande.NCOM = detail.NCOM
and detail.NPRO = produit.NPRO
and produit.NPRO = 'CS464'

-- 17.
select client.NCLI, client.NOM 
from dbo.CLIENT client
where client.NCLI not in 
    (select commande.NCLI from dbo.COMMANDE commande) 
and client.LOCALITE = 'Namur'

-- 18.
select * 
from dbo.PRODUIT produit,
    dbo.COMMANDE commande,
    dbo.DETAIL detail
where produit.NPRO = detail.NPRO
and detail.NCOM = commande.NCOM
and produit.LIBELLE like 'PL%'

-- 19.
select produit.NPRO, produit.LIBELLE 
from dbo.PRODUIT produit,
    dbo.CLIENT client,
    dbo.DETAIL detail,
    dbo.COMMANDE commande
where produit.NPRO = detail.NPRO
and detail.NCOM = commande.NCOM
and client.NCLI = commande.NCLI
and produit.LIBELLE like '%SAPIN%'
and client.LOCALITE = 'Namur'
