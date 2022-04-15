CREATE INDEX `status_updated_at_idx` ON `record` (`status`, `updated_at` DESC, `record_id` ASC);
CREATE INDEX `linked_record_id_created_at_idx` ON `record_comment` (`linked_record_id`, `created_at` DESC);
CREATE INDEX `sta_c_by_u_at_record_id` ON `record` (
  `status`,
  `created_by`,
  `updated_at` DESC,
  `record_id` ASC
);
CREATE INDEX `sta_c_by_u_at_record_id` ON `record_item_file` (`linked_record_id`, `item_id` ASC);
CREATE INDEX `value_idx` ON `session` (`value`);
CREATE INDEX `sta_cat_id_app_group_u_at_r_id_idx` ON `record` (
  `status`,
  `category_id`,
  `application_group`,
  `updated_at` DESC,
  `record_id`
);
