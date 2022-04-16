select
  rc.comment_id,
  rc.value,
  rc.created_by,
  user.name as created_by_name,
  group_info.name as created_by_primary_group_name,
  rc.created_at
from
  record_comment AS rc
  inner join user on rc.created_by = user.user_id
  inner join group_member on group_member.user_id = user.user_id
  AND group_member.is_primary = true
  inner join group_info on group_member.group_id = group_info.group_id
where
  rc.linked_record_id = ?
  AND group_member.is_primary = true
order by
  created_at desc
