CREATE INDEX `sta_c_by_u_at_record_id` ON `record` (
  `status`,
  `created_by`,
  `updated_at` DESC,
  `record_id` ASC
);
