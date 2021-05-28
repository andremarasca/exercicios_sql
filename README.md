# Exercícios SQL

+ Instalação
    + conda install sqlite
+ Abrir um banco
    + sqlite3 banco.db
        + Se eu digitar sqlite3 nome_arquivo.db e ele não existir, ele cria um arquivo.
+ Modo caixa desenhada
    + .mode box

## Criando tabela

+ Digitar o comando no terminal:
    + sqlite3 banco.db
        + Isso vai fazer ele criar um banco de dados novo, e vai entrar dentro do banco.

+ Em seguida, para carregar o arquivo .sql
    + sqlite>
        + .read create.sql

+ Listar quantidade de visitas que cada site recebeu
``` sql
SELECT COUNT(id), site
FROM Visited
GROUP BY site
ORDER BY COUNT(id) DESC;
```
+ Listar sites que nao receberam visitas
    + É Necessário usar JOIN LEFT EXCLUSIVE
``` sql
SELECT A.name
FROM Site A
LEFT OUTER JOIN Visited B
ON A.name = B.site
WHERE B.site is NULL;
```
+ Listar métricas que foram observadas na tabela survey
    + Não tenho certeza do que é "métricas" nesse contexto.
    + Então vou listar os valores únicos de quant
``` sql
SELECT DISTINCT quant
FROM Survey;
```
+ Listar pessoas que fizeram mais de dois levantamentos
    + Aqui precisou de mais levantamentos pra poder listar mais de uma pessoa, por isso inseri a mais além dos exemplos.
``` sql
SELECT COUNT(person), person
FROM Survey
GROUP BY person
HAVING COUNT(person) > 2;
```
+ Listar pessoas que o sobrenome possua DYE no meio da palavra
``` sql
SELECT *
FROM Person
WHERE family LIKE '%DYE%';
```
+ Listar visitações a uma lista de sites passados como parâmetro.
    + Eu acredito que para ter parâmetros é necessário ser uma função.
        + Então só colocarei os nomes de site diretamente no SQL.
    + Aqui precisou de mais visitações aos sites para ter motivo de usar lista, por isso inseri a mais.
``` sql
SELECT *
FROM Visited
WHERE site in ('DR-1', 'DR-2');
```
+ Verifique quantas linhas possuem valor nulo na coluna quant na tabela survey
    + Aqui precisou de instâncias de survey com quant null, por isso inseri a mais.
``` sql
SELECT COUNT(*) as QTD
FROM Survey
WHERE quant is NULL;
```
+ Retorne a media de lat lon utilizando como parâmetro de busca um intervalo de datas
    + Não sei fazer - Buscar depois.
+ Retorne a quantidade de medições realizadas por cada pessoa na tabela person
    + Person não tem medições, considerar "tabela survey", já tinha sido feito em uma das questões anteriores.
``` sql
SELECT COUNT(person), person
FROM Survey
GROUP BY person;
```
+ Retorne a pessoa que tem a maior quantidade de medições de temperatura entre 10 e 30
    + Vou fazer entre 7 e 10 para não precisar inserir dados.
``` sql
SELECT MAX(contagem), person
from (
    SELECT COUNT(person) as contagem, person
    FROM Survey
    where reading BETWEEN 7 and 10
    GROUP BY person
);
```
# ENTRADAS E SAÍDAS DO MEU TERMINAL

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