truncate table target_inventory

truncate table unity_inventory

-- Using script results from unity and roger that generate sql insert statements
-- from existing inventories, load the unity_inventory and target_inventory
-- tables by opening a sql window, opening the insert statement file, and
-- runnning the both files of insert statements.

commit

select count(*) from unity_inventory

select count(*) from target_inventory

drop table push_to_target_inventory

create table push_to_target_inventory as
select path from unity_inventory
minus 
select path from target_inventory

select count(*) from push_to_target_inventory


select 'globus-url-copy -cd -p 5 file:///projects/jwendel/lidar/projects/' || i.path ||  ' gsiftp://cg-hm02.ncsa.illinois.edu/gpfs_scratch/usgs/3DEP/projects/' || i.path 
from push_to_target_inventory i, las_project_files f
where i.path = f.path
order by f.stock_id desc

-- save the above result in a file and run it from unity.

select 
'mkdir -p z:/jwendel/lidar/projects/' ||regexp_replace(f.path, '/[^\/]+\.zip$', '') ||  chr(10) ||
'cd z:/jwendel/lidar/projects/' ||regexp_replace(f.path, '/[^\/]+\.zip$', '') ||  chr(10) ||
'lftp -c ''open suef.cr.usgs.gov && ' || 
'cd /vdelivery/Datasets/Staged/Elevation/LPC/Projects/' || regexp_replace(f.path, '/[^\/]+\.zip$', '') || ' && ' || 
'get ' || substr(regexp_substr(f.path, '/[^\/]+\.zip$'),2) || '''' || chr(10) ||
'echo ' || f.path || '  >> z:/jwendel/lidar/projects.log'  || chr(10) 
from las_project_files f 
where f.path not in (select t.path from target_inventory t)
and   f.path not in (select u.path from unity_inventory u)
--and stock_id = 6389783
order by f.stock_id desc


-- save the above result and run it from a cygwin window on harmorny to pull from rockyftp


select 
'mkdir -p z:/jwendel/lidar/projects/' ||regexp_replace(f.path, '/[^\/]+\.zip$', '') || '; ' || 
'cp x:/' || f.path || ' z:/jwendel/lidar/projects/' || f.path ||  '; ' || 
'echo ' || f.stock_id || '  >> z:/jwendel/lidar/projects.log' 
from las_project_files f 
where f.path not in (select t.path from target_inventory t)
and   f.path not in (select u.path from unity_inventory u)
order by f.stock_id desc

-- save the above result and run in from a cygwin window on harmony to pull from the netapp share
