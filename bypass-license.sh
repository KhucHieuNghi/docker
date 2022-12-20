curl -X POST \
  'https://prm.prm.local/auth/login' \
  --header 'Accept: */*' \
  --header 'mrbs-api-key: mrbs_api_v1.0' \
  --header 'mrbs-client-key: wmc_client' \
  --header 'Content-Type: application/json' \
  --data-raw '{"email":"superadmin","password":"P@ssw0rd"}'