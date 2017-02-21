create table las_projects as 
select regexp_replace(regexp_substr(s.absolute_path, '/[P|p][R|r][O|o][J|j][E|e][C|c][T|t][S|s]/([^/]+)'), '/projects/', '', 1, 1, 'i')  name, min(s.id) min_stock_id
from items i , stock s where itcl_id = 586 and i.id = s.item_id
group by regexp_replace(regexp_substr(s.absolute_path, '/[P|p][R|r][O|o][J|j][E|e][C|c][T|t][S|s]/([^/]+)'), '/projects/', '', 1, 1, 'i')

create unique index las_projects_pk on las_projects(name)

create unique index las_projects_uk1 on las_projects(min_stock_id)

create table las_project_files as 
select regexp_replace(regexp_substr(s.absolute_path, '/[P|p][R|r][O|o][J|j][E|e][C|c][T|t][S|s]/([^/]+)'), '/projects/', '', 1, 1, 'i')  project_name,
regexp_replace(regexp_substr(s.absolute_path, '/[P|p][R|r][O|o][J|j][E|e][C|c][T|t][S|s]/(.+)'), '/projects/', '', 1, 1, 'i') path, 
s.id stock_id
from items i , stock s where itcl_id = 586 and i.id = s.item_id

create unique index las_project_files_pk on las_project_files(project_name, path)

create unique index las_project_files_uk1 on las_project_files(stock_id)

create table unity_inventory(path varchar2(1024))

create unique index unity_inventory_pk on unity_inventory(path)

create table target_inventory(path varchar2(1024))

create unique index target_inventory_pk on unity_inventory(path)
