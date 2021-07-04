CREATE TABLE kitchenlog_users (
id BiGSERIAL UNIQUE PRIMARY KEY,
uuid VARCHAR(32) NOT NULL UNIQUE DEFAULT lpad(md5(random()::text), 32),
name TEXT UNIQUE NOT NULL,
email TEXT UNIQUE NOT NULL,
password TEXT NOT NULL,
admin BOOLEAN NOT NULL DEFAULT false,
disabled BOOLEAN NOT NULL DEFAULT false,
created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT (now() AT TIME ZONE 'utc'),
updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE kitchenlog_recipes (
id BIGSERIAL UNIQUE PRIMARY KEY,
uuid VARCHAR(32) NOT NULL UNIQUE DEFAULT lpad(md5(random()::text), 32),
title TEXT UNIQUE NOT NULL DEFAULT concat('#', random()::text),
description TEXT NOT NULL DEFAULT '',
published BOOLEAN NOT NULL DEFAULT false,
tags TEXT[] NOT NULL DEFAULT '{}',
created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT (now() AT TIME ZONE 'utc'),
updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE kitchenlog_images (
id BIGSERIAL UNIQUE PRIMARY KEY,
uid VARCHAR(16) NOT NULL DEFAULT lpad(md5(random()::text), 16),
reference BIGINT NOT NULL REFERENCES kitchenlog_recipes(id) ON DELETE CASCADE,
lo oid DEFAULT lo_create(0),
size BIGINT NOT NULL,
mime TEXT NOT NULL,
created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT (now() AT TIME ZONE 'utc'),
updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE OR REPLACE FUNCTION kitchenlog_recipes_title_task()
RETURNS TRIGGER AS $$
BEGIN
NEW.title = concat('Recipe #', NEW.id);
RETURN NEW;
END;
$$ language 'plpgsql';

CREATE OR REPLACE FUNCTION kitchenlog_updated_at_task()
RETURNS TRIGGER AS $$
BEGIN
NEW.updated_at = now() AT TIME ZONE 'utc';
RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER kitchenlog_recipes_title_trigger BEFORE
INSERT ON kitchenlog_recipes
FOR EACH ROW EXECUTE PROCEDURE kitchenlog_recipes_title_task();

CREATE TRIGGER kitchenlog_updated_users_trigger BEFORE
INSERT OR UPDATE ON kitchenlog_users
FOR EACH ROW EXECUTE PROCEDURE kitchenlog_updated_at_task();

CREATE TRIGGER kitchenlog_updated_recipes_trigger BEFORE
INSERT OR UPDATE ON kitchenlog_recipes
FOR EACH ROW EXECUTE PROCEDURE kitchenlog_updated_at_task();

CREATE TRIGGER kitchenlog_updated_images_trigger BEFORE
INSERT OR UPDATE ON kitchenlog_images
FOR EACH ROW EXECUTE PROCEDURE kitchenlog_updated_at_task();

COMMIT;
