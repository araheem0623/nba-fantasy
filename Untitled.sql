-- Combining Player and Team Stats into a Single Result Set using UNION ALL

-- Top 10 Players by Points per Game
(SELECT name, team, ppg AS stat_value, 'Points per Game' AS stat_type
FROM nba_player_stats
ORDER BY ppg DESC
LIMIT 10)

UNION ALL

-- Top 10 Players by Assists per Game
(SELECT name, team, apg AS stat_value, 'Assists per Game' AS stat_type
FROM nba_player_stats
ORDER BY apg DESC
LIMIT 10)

UNION ALL

-- Top 10 Players (Age > 30) by Points per Game
(SELECT name, team, ppg AS stat_value, 'Points per Game (Age > 30)' AS stat_type
FROM nba_player_stats
WHERE age > 30
ORDER BY ppg DESC
LIMIT 10)

UNION ALL

-- Top 10 Teams by Total Free Throw Attempts
(SELECT '' AS name, team, SUM(fta) AS stat_value, 'Total Free Throw Attempts' AS stat_type
FROM nba_player_stats
GROUP BY team
ORDER BY stat_value DESC
LIMIT 10)

UNION ALL

-- Players with Above-Average PPG and Below-Average TO%
(SELECT name, team, ppg AS stat_value, 'PPG with Low TO%' AS stat_type
FROM nba_player_stats
WHERE ppg > (SELECT AVG(ppg) FROM nba_player_stats)
AND to_pct < (SELECT AVG(to_pct) FROM nba_player_stats))

UNION ALL

-- Total Rebounds + Assists by Team
(SELECT '' AS name, team, SUM(rpg + apg) AS stat_value, 'Total Rebounds + Assists' AS stat_type
FROM nba_player_stats
GROUP BY team
ORDER BY stat_value DESC)

UNION ALL

-- Average Points per Game by Position
(SELECT '' AS name, pos AS team, AVG(ppg) AS stat_value, 'Average Points per Game (By Position)' AS stat_type
FROM nba_player_stats
GROUP BY pos)

UNION ALL

-- Top 5 Centers by Position
(SELECT name, team, ppg AS stat_value, 'Top Centers by PPG' AS stat_type
FROM nba_player_stats
WHERE pos = 'C'
ORDER BY ppg DESC
LIMIT 5)

UNION ALL

-- Top 5 Guards by Position
(SELECT name, team, ppg AS stat_value, 'Top Guards by PPG' AS stat_type
FROM nba_player_stats
WHERE pos = 'G'
ORDER BY ppg DESC
LIMIT 5)

UNION ALL

-- Top 5 Forwards by Position
(SELECT name, team, ppg AS stat_value, 'Top Forwards by PPG' AS stat_type
FROM nba_player_stats
WHERE pos = 'F'
ORDER BY ppg DESC
LIMIT 5)

UNION ALL

-- Top 5 Guard-Forwards by Position
(SELECT name, team, ppg AS stat_value, 'Top Guard-Forwards by PPG' AS stat_type
FROM nba_player_stats
WHERE pos = 'G-F'
ORDER BY ppg DESC
LIMIT 5);
