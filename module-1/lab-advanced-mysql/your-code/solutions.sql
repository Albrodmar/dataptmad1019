--- Challengue 1

---step1

SELECT titles.title_id, authors.au_id, titles.price*sales.qty*titles.royalty/100*titleauthor.royaltyper/100
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id

---step2
SELECT titles.title_id, authors.au_id, SUM (titles.price*sales.qty*titles.royalty/100*titleauthor.royaltyper/100) AS froyalties
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, titles.title_id

---step3

WITH final_royalties AS
(
SELECT titles.title_id, authors.au_id, SUM (titles.price*sales.qty*titles.royalty/100*titleauthor.royaltyper/100) AS froyalties 
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, titles.title_id
)
SELECT au_id, froyalties+titles.advance
FROM final_royalties
JOIN titles ON final_royalties.title_id = titles.title_id
ORDER BY froyalties+titles.advance DESC
LIMIT 3

-- Creating Temporary Table
SELECT titles.title_id, authors.au_id, SUM (titles.price*sales.qty*titles.royalty/100*titleauthor.royaltyper/100) AS froyalties 
INTO #temp_table
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, titles.title_id

-- Challenge 3 (create a permanent table)
CREATE TABLE IF NOT EXISTS most_profiting_authors AS 
WITH final_royalties AS
(
SELECT titles.title_id, authors.au_id, SUM (titles.price*sales.qty*titles.royalty/100*titleauthor.royaltyper/100) AS froyalties 
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, titles.title_id
)
SELECT au_id, froyalties+titles.advance
FROM final_royalties
JOIN titles ON final_royalties.title_id = titles.title_id
ORDER BY froyalties+titles.advance DESC
LIMIT 3





