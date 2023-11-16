/* 逻辑删除	addBy：钟世云 2018.07.16 */
ALTER TABLE `zcurd_head` ADD `delete_flag_field` VARCHAR(50)  NULL  DEFAULT NULL  COMMENT '删除标志字段'  AFTER `handle_class`;
