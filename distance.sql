-- nullsec to low
SELECT a.solarSystemID AS sourceSystemID,
       a.solarSystemName AS sourceSystem,
       a.security,
       b.solarSystemID AS destSystemID,
       b.solarSystemName AS destSystem,
       b.security,
       MIN((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y) + (a.z - b.z)*(a.z - b.z)) AS distance
FROM mapSolarSystems AS a
JOIN mapSolarSystems AS b
WHERE b.security >= 0.0
  AND ROUND(b.security, 1) < 0.5
  AND a.security < 0.0
  AND a.securityClass IS NOT NULL
  AND  -- Make sure destination system has a station
    (SELECT 1
     FROM staStations AS stations
     WHERE b.solarSystemID == stations.solarSystemID)
GROUP BY a.solarSystemID

UNION

-- lowsec to low
SELECT a.solarSystemID AS sourceSystemID,
       a.solarSystemName AS sourceSystem,
       a.security,
       b.solarSystemID AS destSystemID,
       b.solarSystemName AS destSystem,
       b.security,
       MIN((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y) + (a.z - b.z)*(a.z - b.z)) AS distance
FROM mapSolarSystems AS a
JOIN mapSolarSystems AS b
WHERE b.security >= 0.0
  AND ROUND(b.security, 1) < 0.5
  AND a.security >= 0.0
  AND ROUND(a.security, 1) < 0.5
  AND  -- Make sure destination system has a station
    (SELECT 1
     FROM staStations AS stations
     WHERE b.solarSystemID == stations.solarSystemID)
GROUP BY a.solarSystemID

UNION

-- highsec to high
SELECT a.solarSystemID AS sourceSystemID,
       a.solarSystemName AS sourceSystem,
       a.security,
       b.solarSystemID AS destSystemID,
       b.solarSystemName AS destSystem,
       b.security,
       MIN((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y) + (a.z - b.z)*(a.z - b.z)) AS distance
FROM mapSolarSystems AS a
JOIN mapSolarSystems AS b
WHERE ROUND(b.security, 1) >= 0.5
  AND ROUND(a.security, 1) >= 0.5
  AND  -- Make sure destination system has a station
    (SELECT 1
     FROM staStations AS stations
     WHERE b.solarSystemID == stations.solarSystemID)
GROUP BY a.solarSystemID
