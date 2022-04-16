select
  record.*,
  user.name,
  group_info.name as application_group_name,
  most_recent_file.item_id,
  comment_count_table.comment_count,
  CASE
    WHEN (
      record.updated_at > record_last_access.access_time
    ) THEN 1
    ELSE 0
  END as is_new
from
  record
  JOIN user ON user.user_id = record.created_by
  LEFT JOIN group_info ON record.application_group = group_info.group_id
  INNER JOIN (
    SELECT
      *
    FROM
      record_item_file
    WHERE
      item_id IN (
        SELECT
          MIN(item_id)
        FROM
          record_item_file
        GROUP BY
          linked_record_id
      )
  ) AS most_recent_file ON record.record_id = most_recent_file.linked_record_id
  INNER JOIN (
    SELECT
      linked_record_id,
      count(*) as comment_count
    FROM
      record_comment
    GROUP BY
      linked_record_id
  ) AS comment_count_table ON comment_count_table.linked_record_id = record.record_id
  INNER JOIN record_last_access ON record_last_access.record_id = record.record_id
  AND record_last_access.user_id = user.user_id
where
  record.status = "open"
order by
  record.updated_at desc,
  record.record_id asc
limit
