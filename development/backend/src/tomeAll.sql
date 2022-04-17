-- select
--   *
-- from
--   record
-- where
--   status = "open"
--   and (category_id, application_group) in ((1, 1))
-- order by
--   updated_at desc,
--   record_id
-- limit
--   10
-- +--------------------------------------+--------+--------+---------+-------------+-------------------+------------+---------------------+---------------------+
-- | record_id                            | status | title  | detail  | category_id | application_group | created_by | created_at          | updated_at          |
-- +--------------------------------------+--------+--------+---------+-------------+-------------------+------------+---------------------+---------------------+
-- | 0191f8cc-7cb2-4704-bb85-a63352d1f965 | open   | t      | d       |           1 |                 1 |          1 | 2022-04-16 16:51:05 | 2022-04-16 16:51:08 |
-- | c6a62ffe-a4dc-48fe-9d24-ed9c53cd7f36 | open   | title1 | detail1 |           1 |                 1 |          1 | 2022-04-16 16:51:00 | 2022-04-16 16:51:02 |
-- | c93a3c63-237a-42c1-b31b-d304256be999 | open   | t      | d       |           1 |                 1 |          1 | 2022-04-16 16:49:49 | 2022-04-16 16:49:52 |
-- | 1cd46551-4d71-4cd6-b764-09ba7c1ccca1 | open   | title1 | detail1 |           1 |                 1 |          1 | 2022-04-16 16:49:44 | 2022-04-16 16:49:46 |
-- | 6b9ef834-21c0-492f-96c0-9389ca9b25a4 | open   | t      | d       |           1 |                 1 |          1 | 2022-04-16 16:44:30 | 2022-04-16 16:44:32 |
-- | b4218cfd-1aba-4827-9a53-a088449bb0f0 | open   | title1 | detail1 |           1 |                 1 |          1 | 2022-04-16 16:44:24 | 2022-04-16 16:44:27 |
-- | 97bc719f-899a-4ca0-92e7-25b3c455cfc4 | open   | t      | d       |           1 |                 1 |          1 | 2022-04-16 16:42:44 | 2022-04-16 16:42:47 |
-- | d7dee18e-8178-4d46-aaa5-ddf4d6cd4d53 | open   | title1 | detail1 |           1 |                 1 |          1 | 2022-04-16 16:42:39 | 2022-04-16 16:42:42 |
-- | 83af774e-e3f9-4fc5-b417-76021e997250 | open   | t      | d       |           1 |                 1 |          1 | 2022-04-16 16:42:10 | 2022-04-16 16:42:13 |
-- | 2d2c5f22-d7d7-470b-a9f1-e6424397071e | open   | title1 | detail1 |           1 |                 1 |          1 | 2022-04-16 16:42:05 | 2022-04-16 16:42:08 |
-- +--------------------------------------+--------+--------+---------+-------------+-------------------+------------+---------------------+---------------------+
-- select
--   category_group.category_id,
--   category_group.application_group
-- from
--   group_member
--   JOIN category_group ON category_group.group_id = group_member.group_id
-- where
--   group_member.user_id = ?
-- select
--   record.record_id,
--   record.title,
--   record.application_group,
--   record.created_by,
--   record.created_at,
--   record.updated_at,
--   user.name,
--   group_info.name as application_group_name
--   -- most_recent_file.item_id,
--   -- comment_count_table.comment_count --   CASE
--   --     WHEN (
--   --       record.updated_at > record_last_access.access_time
--   --     ) THEN 1
--   --     ELSE 0
--   --   END as is_new
-- from
--   record
--   JOIN category_group ON (
--     category_group.category_id = record.category_id --     AND category_group.application_group = record.application_group --   )
--   JOIN group_member ON (group_member.group_id = category_group.group_id)
--   JOIN user ON user.user_id = record.created_by
--   JOIN group_info ON group_info.group_id = record.application_group -- INNER JOIN (
--   --   SELECT
--   --     *
--   --   FROM
--   --     record_item_file
--   --   WHERE
--   --     item_id IN (
--   --       SELECT
--   --         MIN(item_id)
--   --       FROM
--   --         record_item_file
--   --       GROUP BY
--   --         linked_record_id
--   --     )
--   -- ) AS most_recent_file ON record.record_id = most_recent_file.linked_record_id
--   -- INNER JOIN (
--   --   SELECT
--   --     linked_record_id,
--   --     count(*) as comment_count
--   --   FROM
--   --     record_comment
--   --   GROUP BY
--   --     linked_record_id
--   -- ) AS comment_count_table ON comment_count_table.linked_record_id = record.record_id --   INNER JOIN record_last_access ON record_last_access.record_id = record.record_id
--   --   AND record_last_access.user_id = user.user_id
-- where
--   record.status = "open"
--   AND group_member.user_id = 1
-- order by
--   record.updated_at desc,
--   record.record_id
-- select
--   record.record_id,
--   record.title,
--   record.application_group,
--   record.created_by,
--   record.created_at,
--   record.updated_at,
--   user.name,
--   group_info.name as application_group_name,
--   CASE
--     WHEN (
--       record.updated_at > COALESCE(
--         record_last_access.access_time,
--         '1970-01-01 00:00:00'
--       )
--     ) THEN 1
--     ELSE 0
--   END as is_new
-- from
--   record
--   JOIN category_group ON (
--     category_group.category_id = record.category_id
--     AND category_group.application_group = record.application_group
--   )
--   JOIN group_member ON (group_member.group_id = category_group.group_id)
--   JOIN user ON user.user_id = record.created_by
--   JOIN group_info ON group_info.group_id = record.application_group
--   INNER JOIN record_last_access ON record_last_access.record_id = record.record_id
--   AND record_last_access.user_id = user.user_id
-- where
--   record.status = "open"
--   AND group_member.user_id = 1
-- order by
--   record.updated_at desc,
--   record.record_id
-- LIMIT
--   10 OFFSET 1;
-- select
--   record_comment.linked_record_id,
--   count(*) as comment_count
-- from
--   record
--   JOIN category_group ON (
--     category_group.category_id = record.category_id
--     AND category_group.application_group = record.application_group
--   )
--   JOIN group_member ON (group_member.group_id = category_group.group_id)
--   JOIN record_comment ON record_comment.linked_record_id = record.record_id
-- where
--   record.status = "open"
--   AND group_member.user_id = 1
-- GROUP BY
--   linked_record_id
-- order by
--   record.updated_at desc,
--   record.record_id
-- LIMIT
-- 10 OFFSET 1;
select
  record.record_id,
  rif1.item_id
from
  record
  JOIN category_group ON (
    category_group.category_id = record.category_id
    AND category_group.application_group = record.application_group
  )
  JOIN group_member ON (group_member.group_id = category_group.group_id)
  JOIN group_info ON group_info.group_id = record.application_group
  INNER JOIN record_item_file AS rif1 ON rif1.linked_record_id = record.record_id
  AND rif1.item_id = (
    SELECT
      MIN(item_id)
    FROM
      record_item_file
    WHERE
      record_item_file.linked_record_id = record.record_id
    GROUP BY
      linked_record_id
  )
where
  record.status = "open"
  AND group_member.user_id = 1
order by
  record.updated_at desc,
  record.record_id
LIMIT
  10 OFFSET 1;
select
  record.record_id,
  record.title,
  record.application_group,
  record.created_by,
  record.created_at,
  record.updated_at,
  user.name,
  group_info.name as application_group_name,
  record_last_access.access_time
from
  record
  JOIN user ON user.user_id = record.created_by
  JOIN category_group ON (
    category_group.category_id = record.category_id
    AND category_group.application_group = record.application_group
  )
  JOIN group_member ON (group_member.group_id = category_group.group_id)
  JOIN group_info ON group_info.group_id = record.application_group
  LEFT JOIN record_last_access ON record_last_access.record_id = record.record_id
  AND record_last_access.user_id = user.user_id
where
  record.status = "open"
  AND group_member.user_id = 3263
order by
  record.updated_at desc,
  record.record_id
LIMIT
  10 OFFSET 1;
select
  record.record_id,
  record.title,
  record.application_group,
  record.created_by,
  record.created_at,
  record.updated_at
from
  record
  JOIN user ON user.user_id = record.created_by
  JOIN category_group ON category_group.category_id = record.category_id
  AND category_group.application_group = record.application_group
  JOIN group_member ON (group_member.group_id = category_group.group_id)
where
  record.status = "open"
  AND group_member.user_id = 3263
order by
  record.updated_at desc,
  record.record_id
LIMIT
  10 OFFSET 1;
select
  record.record_id,
  record.title,
  record.application_group,
  record.created_by,
  record.created_at,
  record.updated_at,
  user.name,
  group_info.name as application_group_name,
  CASE
    WHEN (
      record.updated_at > COALESCE(
        record_last_access.access_time,
        '1970-01-01 00:00:00'
      )
    ) THEN 1
    ELSE 0
  END as is_new
from
  record
  JOIN category_group ON (
    category_group.category_id = record.category_id
    AND category_group.application_group = record.application_group
  )
  JOIN group_member ON (group_member.group_id = category_group.group_id)
  JOIN user ON user.user_id = record.created_by
  JOIN group_info ON group_info.group_id = record.application_group
  LEFT JOIN record_last_access ON record_last_access.record_id = record.record_id
  AND record_last_access.user_id = user.user_id
where
  record.status = "open"
  AND group_member.user_id = 1
order by
  record.updated_at desc,
  record.record_id
Limit
  10;
