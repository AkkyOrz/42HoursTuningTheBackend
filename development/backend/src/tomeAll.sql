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
select
  record.*
from
  record
  JOIN category_group ON (
    category_group.category_id = record.category_id
    AND category_group.application_group = record.application_group
  )
  JOIN group_member ON (
    group_member.group_id = category_group.group_id
    AND group_member.user_id = ?
  )
where
  record.status = "open"
order by
  record.updated_at desc,
  record.record_id
limit ? offset ?
