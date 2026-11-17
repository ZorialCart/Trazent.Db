-- functions/20261116_172257_create_site.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:22:57 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.create_site(
    p_company_id uuid,
    p_name character varying,
    p_address character varying DEFAULT NULL,
    p_latitude double precision DEFAULT NULL,
    p_longitude double precision DEFAULT NULL,
    p_radius_meters integer DEFAULT 100
) RETURNS uuid
    LANGUAGE plpgsql
AS $function$
DECLARE
    v_id uuid;
    v_name text := NULLIF(btrim(COALESCE(p_name, '')), '');
BEGIN
    INSERT INTO public.sites (company_id, name, address, latitude, longitude, radius_meters)
    VALUES (p_company_id, v_name, NULLIF(btrim(COALESCE(p_address, '')), ''),
            p_latitude, p_longitude, p_radius_meters)
    RETURNING id INTO v_id;

    RETURN v_id;
END;
$function$;
