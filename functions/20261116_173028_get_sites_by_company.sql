-- functions/20261116_173028_get_sites_by_company.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:30:28 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.get_sites_by_company(
    p_company_id uuid,
    p_is_active boolean DEFAULT NULL
) RETURNS TABLE(
    site_id uuid,
    name character varying,
    address character varying,
    latitude double precision,
    longitude double precision,
    radius_meters integer,
    is_active boolean,
    assigned_contractors integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
)
    LANGUAGE plpgsql STABLE
AS $function$
BEGIN
    RETURN QUERY
    SELECT s.id, s.name, s.address, s.latitude, s.longitude, s.radius_meters, s.is_active,
           (SELECT count(*)::integer FROM public.site_assignments sa WHERE sa.site_id = s.id),
           s.created_at, s.updated_at
      FROM public.sites s
     WHERE s.company_id = p_company_id
       AND (p_is_active IS NULL OR s.is_active = p_is_active)
     ORDER BY s.name;
END;
$function$;
