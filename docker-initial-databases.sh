set -e

# Set the script as executable because Docker copies over permissions...
# >> chmod +x docker-postgresql-multiple-databases.sh

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname root <<-EOSQL
	CREATE DATABASE pes;
	CREATE DATABASE mrbs;
	
	GRANT ALL PRIVILEGES ON DATABASE mrbs TO postgres;
	GRANT ALL PRIVILEGES ON DATABASE pes TO postgres;

EOSQL
	# FLUSH PRIVILEGES;