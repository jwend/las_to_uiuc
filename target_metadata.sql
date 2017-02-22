select s.id stock_id, f.project_name, f.path, s.byte_count, s.byte_count_unzipped, i.full_name, i.west_longitude, i.south_latitude, i.east_longitude, i.north_latitude, 
to_char(i.header_source_date, 'YYYY-MM-DD') source_date, to_char(i.publication_date, 'YYYY-MM-DD') publication_date
from stock s, las_project_files f, target_inventory ti, items i
where s.id = f.stock_id
and   ti.path = f.path
and i.id = s.item_id
--and s.id = 8240913 
