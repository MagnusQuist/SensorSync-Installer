BEGIN;

CREATE TABLE IF NOT EXISTS public.device
(
    uuid uuid DEFAULT gen_random_uuid(),
    name character varying(54) COLLATE pg_catalog."default",
    athena_version character varying(10) COLLATE pg_catalog."default",
    toit_firmware_version character varying(10) COLLATE pg_catalog."default",
    date_created timestamp without time zone
);

END;