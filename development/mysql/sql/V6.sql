CREATE INDEX `sta_cat_id_app_group_u_at_r_id_idx` ON `record` (
  `status`,
  `category_id`,
  `application_group`,
  `updated_at` DESC,
  `record_id`
);
