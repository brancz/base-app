include:
  - postgresql

base_app_postgres_user:
  postgres_user.present:
    - name: base_app
    - password: password1
    - runas: postgres
    - createdb: true
