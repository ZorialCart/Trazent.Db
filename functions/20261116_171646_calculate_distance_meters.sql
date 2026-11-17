-- functions/20261116_171646_calculate_distance_meters.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:16:46 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.calculate_distance_meters(
    p_lat1 double precision,
    p_lon1 double precision,
    p_lat2 double precision,
    p_lon2 double precision
) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE
AS $function$
    SELECT 2 * 6371000.0 * asin(LEAST(1.0, sqrt(
        power(sin(radians(p_lat2 - p_lat1) / 2), 2) +
        cos(radians(p_lat1)) * cos(radians(p_lat2)) *
        power(sin(radians(p_lon2 - p_lon1) / 2), 2)
    )));
$function$;
