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
        record.updated_at > COALESCE(record_last_access.access_time, '1970-01-01 00:00:00')
      ) THEN 1
      ELSE 0
    END as is_new
from
  record
  JOIN user ON user.user_id = record.created_by
  JOIN group_info ON group_info.group_id = record.application_group
  LEFT JOIN record_last_access ON record_last_access.record_id = record.record_id
    AND record_last_access.user_id = user.user_id
where
  record.status = "open"
order by
  record.updated_at desc,
  record.record_id asc
LIMIT ? OFFSET ?;


select
  record.record_id,
  rif1.item_id
from
  record
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
order by
  record.updated_at desc,
  record.record_id ASC
LIMIT
  ? OFFSET ?;


select
  record_comment.linked_record_id,
  count(*) as comment_count
from
  record
  JOIN group_info ON group_info.group_id = record.application_group
  JOIN record_comment ON record_comment.linked_record_id = record.record_id
where
  record.status = "open"
GROUP BY
  record.record_id
order by
  record.updated_at desc,
  record.record_id ASC
LIMIT
  ? OFFSET ?
