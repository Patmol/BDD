-- (a)
select * from PRODUIT

-- (b)
select * from PRODUIT
where LIBELLE like '%ACIER%'

-- (c)
select distinct LOCALITE
from CLIENT

-- (d)
select distinct CAT 
from client
where LOCALITE = 'Toulouse'

-- (e)
select NCLI, NOM, LOCALITE
from CLIENT
where CAT = 'C1'
and LOCALITE <> 'Toulouse'

-- (f)
select NCLI, NOM, COMPTE
from CLIENT
where LOCALITE in ('Poitiers', 'Bruxelles')
and COMPTE > 0

-- (g)
-- i)
select * from CLIENT
where LOCALITE in ('Lille', 'Namur')

-- ii)
select * from CLIENT
where LOCALITE = 'Lille'
and LOCALITE <> 'Namur'

-- iii)
select * from CLIENT
where LOCALITE not in ('Lille', 'Namur')

-- iv)
select * from CLIENT
where LOCALITE <> 'Namur'
or LOCALITE <> 'Lille'

-- v)
select * from CLIENT
where CAT = 'C1'
and LOCALITE = 'Namur'

-- vi)
select * from CLIENT
where CAT = 'C1'
or LOCALITE = 'Namur'

-- vii)
select * from CLIENT
where CAT = 'C1'
and LOCALITE <> 'Namur'

-- viii)
select * from CLIENT
where NCLI not in 
    (select NCLI from CLIENT
    where CAT = 'C1'
    and LOCALITE <> 'Namur')

-- ix)
select * from CLIENT
where CAT in ('B1', 'C1')
or LOCALITE in ('Lille', 'Namur')

-- x)
select * from CLIENT
where (CAT in ('B1', 'C1') and LOCALITE not in ('Lille', 'Namur'))
or (CAT not in ('B1', 'C1') and LOCALITE in ('Lille', 'Namur'))

-- xi)
select * from CLIENT
where CAT in ('B1', 'C1')
and LOCALITE in ('Lille', 'Namur')

-- xii)
select * from CLIENT
where NCLI not in
    (select NCLI from CLIENT
    where CAT in ('B1', 'C1')
    and LOCALITE in ('Lille', 'Namur'))

select * from CLIENT
where not (CAT in ('B1', 'C1')
    and LOCALITE in ('Lille', 'Namur'))

-- (h)
select NCLI, NOM, LOCALITE
from CLIENT
where NOM < LOCALITE

-- (i)
-- i)
select LOCALITE from CLIENT
where NCLI in
    (select NCLI from COMMANDE
    where NCOM in 
        (select NCOM from DETAIL
        where NPRO = 'CS464'))

-- ii)
select distinct LOCALITE from CLIENT
where NCLI in
    (select NCLI from COMMANDE
    where NCOM in 
        (select NCOM from DETAIL
        where NPRO = 'CS464'))

-- (j)
select CLIENT.NCLI, CLIENT.NOM
from CLIENT
where NCLI not in 
    (select NCLI from COMMANDE)
and LOCALITE = 'Namur'

-- (k)
select *
from PRODUIT
where LIBELLE like '%SAPIN%'
and NPRO in (select NPRO from DETAIL)

-- (l)
-- i)
select NPRO, LIBELLE
from PRODUIT
where LIBELLE like '%SAPIN%'
and NPRO not in
    (select NPRO from DETAIL)

-- ii)
select NPRO, LIBELLE
from PRODUIT
where LIBELLE like '%SAPIN%'
and NPRO in
    (select NPRO from DETAIL
    where NCOM in
        (select NCOM from COMMANDE
        where NCLI in (
            select NCLI
            from CLIENT
            where LOCALITE = 'Toulouse'
        )))

-- iii)
select NPRO, LIBELLE
from PRODUIT
where LIBELLE like '%SAPIN%'
and NPRO not in
    (select NPRO from DETAIL
    where NCOM in
        (select NCOM from COMMANDE
        where NCLI in (
            select NCLI
            from CLIENT
            where LOCALITE = 'Toulouse'
        )))

-- iv)
select NPRO, LIBELLE
from PRODUIT
where LIBELLE like '%SAPIN%'
and NPRO in
    (select NPRO from DETAIL
    where NCOM in
        (select NCOM from COMMANDE
        where NCLI in (
            select NCLI
            from CLIENT
            where LOCALITE = 'Toulouse'
        )))
and NPRO not in
    (select NPRO from DETAIL
    where NCOM in
        (select NCOM from COMMANDE
        where NCLI in (
            select NCLI
            from CLIENT
            where LOCALITE <> 'Toulouse'
        ))) 

-- v)
select NPRO, LIBELLE
from PRODUIT
where LIBELLE like '%SAPIN%'
and NPRO in
    (select NPRO from DETAIL
    where NCOM in
        (select NCOM from COMMANDE
        where NCLI in (
            select NCLI
            from CLIENT
            where LOCALITE = 'Toulouse'
        )))
and NPRO in
    (select NPRO from DETAIL
    where NCOM in
        (select NCOM from COMMANDE
        where NCLI in (
            select NCLI
            from CLIENT
            where LOCALITE <> 'Toulouse'
        )))

-- (m)
select LOCALITE
from CLIENT
where NCLI in
    (select NCLI from COMMANDE
    where YEAR(DATECOM) = 2015 and MONTH(DATECOM) = 12)

-- (n)
select 
    SUM(compte) as 'Sum', 
    MIN(compte) as 'Min', 
    AVG(compte) as 'Avg', 
    MAX(compte) as 'Max'
from CLIENT