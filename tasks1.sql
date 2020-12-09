-- Сделать запрос, в котором мы выберем все данные о городе – регион, страна.

SELECT 
    _countries.title AS country,
    _regions.title AS region,
    _cities.title AS citi
FROM
    _cities
        JOIN
    (_countries, _regions) ON (_cities.country_id = _countries.id
        AND _cities.region_id = _regions.id)
WHERE
    _cities.title = 'Тюмень'
;

-- Выбрать все города из Московской области.
SELECT 
    _countries.title AS country,
    _regions.title AS region,
    _cities.title AS citi
FROM
    _regions
        JOIN
    (_countries, _cities) ON (_cities.country_id = _countries.id
        AND _cities.region_id = _regions.id)
WHERE
    _regions.title = 'Московская область'
;