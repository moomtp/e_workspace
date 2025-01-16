##### test service (POST request) by shell
```bash
curl -X POST \ -H "Content-Type: application/json" \ -d '{ "client_id": "client_id_A", "client_secret": "client_secret_A", "grant_type": "client_credentials" }' \ http://127.0.0.1:8080/api/token
```


