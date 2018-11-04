#!/usr/bin/env bash
docker-compose exec web node assets/node_modules/brunch/bin/brunch build /app/assets
