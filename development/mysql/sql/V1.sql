CREATE INDEX `status_updated_at_idx` ON `record` (`status`, `updated_at` DESC, `record_id` ASC);
