delete from objects where id in (
select id from tree where template_id 
in (select id from templates where type like '%case%' or template_id in (1598,3269,1205,1976)));

delete from tree_info where id in (
select id from tree where template_id 
in (select id from templates where type like '%case%' or template_id in (1598,3269,1205,1976)));

delete from tree where template_id in 
(select id from templates where type like '%case%' or template_id in (1598,3269,1205,1976));

delete from objects where id not in (select id from tree_info);

delete from tree where id not in (select id from tree_info);

delete from objects where id in (select id from tree where did = 1);
delete from tree_info where id in (select id from tree where did = 1);
delete from tree where did = 1;
delete from favorites;
delete from action_log;
delete from files;
delete from file_previews;
delete from files_content;


delete from users_groups_association where user_id in (select id from users_groups where id not in (1,2,22,34,30,315));
delete from tree_acl_security_sets_result where user_id in (select id from users_groups where id not in (1,2,22,34,30,315));
delete from tree_acl where id not in (select id from tree_acl_security_sets_result);
delete from notifications;
delete from users_groups where id not in (1,2,22,34,30,315);
