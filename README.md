# Exercícios SQL

+ Instalação
    + conda install sqlite
+ Abrir um banco
    + sqlite3 banco.db
        + Se eu digitar sqlite3 nome_arquivo.db e ele não existir, ele cria um arquivo.
+ Modo caixa desenhada
    + .mode box

## Criando tabela

Digitar o comando no terminal:
+ sqlite3 banco.db
    + Isso vai fazer ele criar um banco de dados novo, e vai entrar dentro do banco.

Em seguida, para carregar o arquivo .sql
+ sqlite>
    + .read create.sql

## Lista de exercícios

### Listar quantidade de visitas que cada site recebeu
``` sql
SELECT COUNT(id), site
FROM Visited
GROUP BY site
ORDER BY COUNT(id) DESC;
```
### Listar sites que nao receberam visitas

É Necessário usar JOIN LEFT EXCLUSIVE
``` sql
SELECT A.name
FROM Site A
LEFT OUTER JOIN Visited B
ON A.name = B.site
WHERE B.site is NULL;
```

### Listar métricas que foram observadas na tabela survey

Basicamente selecionar os valores distintos de quant em Survey

``` sql
SELECT DISTINCT quant
FROM Survey;
```

### Listar pessoas que fizeram mais de dois levantamentos

``` sql
SELECT COUNT(person), person
FROM Survey
GROUP BY person
HAVING COUNT(person) > 2;
```

### Listar pessoas que o sobrenome possua DYE no meio da palavra

``` sql
SELECT *
FROM Person
WHERE family LIKE '%DYE%';
```

### Listar visitações a uma lista de sites passados como parâmetro.

Criar uma lista de sites e consultar se o nome do site está dentro dessa lista

``` sql
SELECT *
FROM Visited
WHERE site in ('DR-1', 'DR-2');
```

### Verifique quantas linhas possuem valor nulo na coluna quant na tabela survey

Aqui precisou de instâncias de survey com quant null, por isso inseri a mais.

``` sql
SELECT COUNT(*) as QTD
FROM Survey
WHERE quant is NULL;
```
### Retorne a media de lat lon utilizando como parâmetro de busca um intervalo de datas

Primeiramente selecionar as datas dentro do intervalo na tabela visited.

``` sql
SELECT * FROM Visited V
WHERE date('1927-01-01') <= date(V.date) and date(V.date) <= date('1927-12-31');
```

Em seguida, usando essa tabela, fazer um join com Site (em site estão os valores de lat e long)

``` sql
SELECT * FROM Site S
INNER JOIN (
    SELECT * FROM Visited V
    WHERE date('1929-01-01') <= date(V.date) and date(V.date) <= date('1929-12-31')
) F
ON S.name = F.site;
```
Agora basta calcular a media em cima das colunas lat e long. OBS: Eu gosto de fazer as coisas aninhadas, mas não precisa ser.

``` sql
SELECT AVG(lat), AVG(long)
FROM (
    SELECT * FROM Site S
    INNER JOIN (
        SELECT * FROM Visited V
        WHERE date('1929-01-01') <= date(V.date) and date(V.date) <= date('1929-12-31')
    ) F
    ON S.name = F.site
);
```
### Retorne a quantidade de medições realizadas por cada pessoa na tabela person

Juntar tabela Person com a tabela Survey, para que quem teve zero medições também apareça.

``` sql
SELECT P.personal, count(S.quant) as quant_medicoes FROM Person P
LEFT OUTER JOIN Survey S ON P.id = S.person
GROUP BY P.personal;
```
### Retorne a pessoa que tem a maior quantidade de medições de temperatura entre 10 e 30

Vou fazer entre 7 e 10 para não precisar inserir dados.

``` sql
SELECT MAX(contagem), person
from (
    SELECT COUNT(person) as contagem, person
    FROM Survey
    where reading BETWEEN 7 and 10
    GROUP BY person
);
```
## ENTRADAS E SAÍDAS DO MEU TERMINAL

``` bash
$ sqlite3 banco.db
SQLite version 3.33.0 2020-08-14 13:23:32
Enter ".help" for usage hints.
sqlite> .mode box
sqlite> .read create.sql
sqlite> .tables
Person   Site     Survey   Visited
sqlite> SELECT * from Person;
┌──────┬──────────┬─────────┐
│  id  │ personal │ family  │
├──────┼──────────┼─────────┤
│ dyer │ William  │ Dyer    │
│ pb   │ Frank    │ Pabodie │
│ am   │ André    │ Marasca │
└──────┴──────────┴─────────┘
sqlite> SELECT * from Site;
┌──────┬────────┬─────────┐
│ name │  lat   │  long   │
├──────┼────────┼─────────┤
│ DR-1 │ -49.85 │ -128.57 │
│ DR-2 │ -42.45 │ -121.02 │
│ DR-3 │ -47.15 │ -126.72 │
│ DR-4 │ 0      │ 0       │
└──────┴────────┴─────────┘
sqlite> SELECT * from Survey;
┌───────┬────────┬───────┬─────────┐
│ taken │ person │ quant │ reading │
├───────┼────────┼───────┼─────────┤
│ 619   │ dyer   │ rad   │ 9.82    │
│ 619   │ dyer   │ sal   │ 0.13    │
│ 622   │ dyer   │ rad   │ 7.8     │
│ 803   │ am     │ abc   │ 3.4     │
│ 800   │ am     │       │ 7.23    │
│ 801   │ am     │       │ 6.47    │
└───────┴────────┴───────┴─────────┘
sqlite> SELECT * from Visited;
┌─────┬──────┬────────────┐
│ id  │ site │    date    │
├─────┼──────┼────────────┤
│ 619 │ DR-1 │ 1927-02-08 │
│ 622 │ DR-1 │ 1927-02-10 │
│ 800 │ DR-2 │ 1929-02-10 │
│ 801 │ DR-2 │ 1929-02-12 │
│ 802 │ DR-3 │ 1929-02-12 │
│ 803 │ DR-3 │ 1929-02-12 │
└─────┴──────┴────────────┘
```