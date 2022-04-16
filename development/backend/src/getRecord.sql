-- select
--   record.*,
--   gi1.name as created_by_primary_group_name,
--   gi2.name as application_group_name,
--   user.name as created_by_name,
--   category.name as category_name
-- from
--   record
--   inner join user on record.created_by = user.user_id
--   inner join group_member gm1 on gm1.user_id = record.created_by
--   AND gm1.is_primary = true
--   inner join group_info gi1 on gi1.group_id = gm1.group_id
--   inner join group_info gi2 on gi2.group_id = record.application_group
--   inner join category on category.category_id = record.category_id
-- where
--   record_id = ?
select
  record_item_file.item_id,
  file.name
from
  record_item_file
JOIN
  file ON file.file_id = record_item_file.linked_file_id
where
  linked_record_id = ?
order by
  item_id asc
