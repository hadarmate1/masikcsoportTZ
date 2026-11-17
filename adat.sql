/*1 feladat*/
SELECT  szolgaltatasok.id, szolgaltatasok.megnevezes, szolgaltatasok.alapar,
 szolgaltatasok.munkaido_perc,szolgaltatasok.aktiv, kategoriak.nev
 FROM szolgaltatasok INNER JOIN kategoriak 
 On kategoriak.id = szolgaltatasok.kategoria_id 
 ORDER BY szolgaltatasok.alapar ASC;
 /*2 feladat*/
 SELECT szolgaltatasok.id, szolgaltatasok.kategoria_id, 
 szolgaltatasok.megnevezes,szolgaltatasok.alapar, 
 szolgaltatasok.munkaido_perc, szolgaltatasok.aktiv
 FROM szolgaltatasok WHERE szolgaltatasok.aktiv = 1 
 AND szolgaltatasok.munkaido_perc <=60;
 /*3 feladat*/
 SELECT szolgaltatasok.id, szolgaltatasok.kategoria_id, 
 szolgaltatasok.megnevezes, szolgaltatasok.alapar, 
 szolgaltatasok.munkaido_perc, szolgaltatasok.aktiv 
 FROM szolgaltatasok WHERE szolgaltatasok.megnevezes LIKE "%:szöveg%";
/*4 feladat*/
 SELECT kategoriak.nev as "Kategória neve",
 COUNT(szolgaltatasok.id) as "szolgaltatasok szama",
 ROUND(AVG(szolgaltatasok.alapar)) as " szolgaltatasok atlag ara"
 FROM kategoriak INNER JOIN szolgaltatasok
 ON kategoriak.id = szolgaltatasok.kategoria_id 
 GROUP BY kategoriak.nev;
 /*5 feladat*/
  SELECT szolgaltatasok.megnevezes, szolgaltatasok.alapar,
  szolgaltatasok.munkaido_perc FROM szolgaltatasok
  WHERE szolgaltatasok.alapar > 25000 
  ORDER BY szolgaltatasok.munkaido_perc DESC;