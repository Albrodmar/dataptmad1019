
SELECT titleauthor.au_id, authors.au_fname, authors.au_lname, SUM(titles.advance + (sales.qty*titles.royalty)) AS 'Earnings'
FROM sales
JOIN titles ON sales.title_id = titles.title_id
JOIN titleauthor ON titles.title_id=titleauthor.title_id
JOIN authors ON titleauthor.au_id = authors.au_id
GROUP BY titleauthor.au_id
ORDER BY SUM(titles.advance + (sales.qty*titles.royalty)) DESC
