# Creates an inventory of the regular files in the projects directory.
# Used by USGS to ensure only files not already in the projects
# directory are not re-copied 
# Must be run from the scripts directory.
cd ../projects
find . -type f -exec ls -1 {} \; > ../scripts/unity_inventory.sql
cd ../scripts
#sed -i 's/^\.\///g' inventory.txt
sed -i 's/^\.\/\(.*\)/insert into unity_inventory values(\x27\1\x27);/g' unity_inventory.sql
