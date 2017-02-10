delete from objects where id in (
select id from tree where template_id 
in (select id from templates where templates.id > 100 && templates.id != 669));

delete from tree_info where id in (
select id from tree where template_id 
in (select id from templates where templates.id > 100 && templates.id != 669));

delete from tree where template_id in 
(select id from templates where templates.id > 100 && templates.id != 669);

delete from objects where id not in (select id from tree_info);

delete from tree where id not in (select id from tree_info);

delete from objects where id in (select id from tree where did = 1);
delete from tree_info where id in (select id from tree where did = 1);
delete from tree where did = 1;
delete from favorites;
delete from action_log;
delete from files;
delete from file_previews;
delete from users_groups_association where user_id in (select id from users_groups where id not in (1,2));
delete from tree_acl_security_sets_result where user_id in (select id from users_groups where id not in (1,2));
delete from tree_acl where id not in (select id from tree_acl_security_sets_result);
delete from notifications;
delete from users_groups where id not in (1,2);


ALTER TABLE ecmrs.users_groups
 CHANGE type type INT(10) UNSIGNED DEFAULT '2',
 CHANGE system system INT(10) UNSIGNED DEFAULT '0',
 CHANGE name name VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci,
 CHANGE email email VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci,
 CHANGE language_id language_id INT(10) UNSIGNED DEFAULT '1',
 CHANGE cfg cfg LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci,
 CHANGE data data LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci,
 CHANGE cdate cdate INT(11) DEFAULT '0',
 CHANGE salt salt VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
 CHANGE roles roles LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '(DC2Type:json_array)';
