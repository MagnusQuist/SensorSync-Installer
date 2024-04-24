-- Create device_groups table
CREATE TABLE IF NOT EXISTS device_group (
    uuid UUID PRIMARY KEY,
    name VARCHAR(255),
    location VARCHAR(255)
);

-- Create device table
CREATE TABLE IF NOT EXISTS device (
    uuid UUID PRIMARY KEY,
    name VARCHAR(255),
    online BOOLEAN,
    athena_version VARCHAR(255),
    toit_firmware_version VARCHAR(255),
    group_uuid UUID,
    last_ping TIMESTAMP,
    date_created TIMESTAMP,
    FOREIGN KEY (group_uuid) REFERENCES device_group(uuid)
);

-- Create _user table
CREATE TABLE IF NOT EXISTS _user (
    uuid UUID PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);

-- Install pg_cron extension
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Create trigger function to update online status
CREATE OR REPLACE FUNCTION update_device_online_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.last_ping < NOW() - INTERVAL '1 minutes' THEN
        UPDATE device
        SET online = FALSE
        WHERE uuid = NEW.uuid;
    ELSE
        UPDATE device
        SET online = TRUE
        WHERE uuid = NEW.uuid;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to execute the trigger function on last_ping update
CREATE TRIGGER device_last_ping_trigger
AFTER UPDATE OF last_ping ON device
FOR EACH ROW
EXECUTE FUNCTION update_device_online_status();

-- Schedule job to update online status periodically
SELECT cron.schedule('update_device_online_status_job', '*/1 * * * *', $$ 
    UPDATE device
    SET online = FALSE
    WHERE last_ping < NOW() - INTERVAL '1 minutes';
$$);