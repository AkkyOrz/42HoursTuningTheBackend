CREATE INDEX `status_u_at_record_id_idx` ON `record` (`status`, `updated_at` DESC, `record_id`);
CREATE INDEX `category_id_app_group_idx` ON `category_group` (`category_id`, `application_group`);
