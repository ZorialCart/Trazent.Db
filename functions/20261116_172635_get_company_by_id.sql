-- functions/20261116_172635_get_company_by_id.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:26:35 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.get_company_by_id(p_id uuid, p_is_active boolean DEFAULT NULL::boolean)
 RETURNS TABLE(company_id uuid, name character varying, plan smallint, is_active boolean, created_at timestamp with time zone, updated_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        c.id,
        c.name,
        c.plan,
        c.is_active,
        c.created_at,
        c.updated_at
    FROM public.companies c
    WHERE c.id = p_id
      AND (p_is_active IS NULL OR c.is_active = p_is_active);
END;
$function$;
