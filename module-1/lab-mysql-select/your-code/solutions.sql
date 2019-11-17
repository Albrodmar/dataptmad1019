--Challenge 1

SELECT a.au_id as 'AUTHOR ID', a.au_lname AS 'LAST NAME', a.au_fname AS 'FIRST NAME', b.title AS 'TITLE', b.pub_name AS 'PUBLISHER'
FROM
(SELECT *
FROM titleauthor
JOIN titles
ON titleauthor.title_id = titles.title_id
JOIN authors
ON titleauthor.au_id = authors.au_id) a
JOIN
(SELECT *
FROM titles
JOIN publishers
ON titles.pub_id = publishers.pub_id) b
ON a.title_id = b.title_id

---Challenge 2

SELECT a.au_id as 'AUTHOR ID', a.au_lname AS 'LAST NAME', a.au_fname AS 'FIRST NAME', b.pub_name AS 'PUBLISHER', COUNT(*) AS 'TITLE COUNT'
FROM
(SELECT *
FROM titleauthor
JOIN titles
ON titleauthor.title_id = titles.title_id
JOIN authors
ON titleauthor.au_id = authors.au_id) a
JOIN
(SELECT *
FROM titles
JOIN publishers
ON titles.pub_id = publishers.pub_id) b
ON a.title_id = b.title_id
GROUP BY a.au_id, b.pub_name
ORDER BY COUNT(*) DESC

-- Challenge 3

SELECT titleauthor.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST NAME', authors.au_fname 'FIRS NAME', SUM (sales.qty) AS 'TOTAL'
FROM sales
JOIN titleauthor ON sales.title_id = titleauthor.title_id
JOIN authors ON titleauthor.au_id = authors.au_id
GROUP BY titleauthor.au_id
ORDER BY SUM(sales.qty) DESC
LIMIT 3

-- Challenge 4

SELECT titleauthor.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST NAME', authors.au_fname 'FIRS NAME', SUM (sales.qty) AS 'TOTAL'
FROM authors
LEFT JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY titleauthor.au_id
ORDER BY SUM(sales.qty) DESC


