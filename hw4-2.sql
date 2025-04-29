-- Week 4 - Who worked with whom?
-- Haylee Oyler

SELECT Site A.Observer AS Observer_1 B.Observer AS Observer_2 FROM Camp_assignment A JOIN Camp_assignment B 
    ON A.Site = B.Site
    AND ((A.Start <= B.End)  AND (A.End >= B.Start))
    WHERE (A.Site = 'lkri' AND A.Observer < B.Observer);
