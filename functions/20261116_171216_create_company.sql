-- functions/20261116_171216_create_company.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:12:16 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.create_company(p_name character varying, p_plan smallint DEFAULT 0)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_id uuid;
    v_name text := NULLIF(btrim(COALESCE(p_name, '')), '');
BEGIN
    INSERT INTO public.companies (name, plan)
    VALUES (v_name, p_plan)
    RETURNING id INTO v_id;

    RETURN v_id;
END;
$function$;
