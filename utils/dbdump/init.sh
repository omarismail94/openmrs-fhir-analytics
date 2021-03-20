#!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script is executed at run time during container initialization / entrypoint
echo "[Entrypoint] Database dump started";
echo "[Entrypoint] Databse dump mode: $DATABASE_DUMP_MODE";
if [[ "$DATABASE_DUMP_MODE" == "big" ]]; then
    echo "[Entrypoint] dumping openmrs_big_sql";
    mysql -u"root" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" -h"$MYSQL_ROOT_HOST" <  /docker-entrypoint-initdb.d/openmrs_big_sql;
else
    echo "[Entrypoint] dumping openmrs_small_sql";
    mysql -u"root" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" -h"$MYSQL_ROOT_HOST" <  /docker-entrypoint-initdb.d/openmrs_small_sql;
fi

echo "[Entrypoint] dumping atomfeed_db_sql";
mysql -u"root" -p"$MYSQL_ROOT_PASSWORD" -h"$MYSQL_ROOT_HOST" <  /docker-entrypoint-initdb.d/atomfeed_db_sql;
echo "[Entrypoint] dumping fhir_concept_sources_sql";
mysql -u"root" -p"$MYSQL_ROOT_PASSWORD"  -h"$MYSQL_ROOT_HOST" <  /docker-entrypoint-initdb.d/fhir_concept_sources_sql;

echo "[Entrypoint] Database dump ended";