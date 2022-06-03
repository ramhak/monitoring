
SELECT
  m.name,
  m.value,
  m.created_at,
  m.uid,
  round(avg(m.value) over minute,2) as avg_per_min ,
  round(avg(m.value) over hour,2) as avg_per_hour,
  round(avg(m.value) over day,2) as avg_per_day
FROM metrics m
-- WHERE m.name = $1 AND m.created_at >= $2 AND m.created_at <= $3
WINDOW minute AS (PARTITION BY date_trunc('minute',m.created_at) ORDER BY m.created_at),
hour AS (PARTITION BY date_trunc('hour',created_at)),
day AS (PARTITION BY date_trunc('day',created_at))
ORDER BY m.created_at DESC ;
