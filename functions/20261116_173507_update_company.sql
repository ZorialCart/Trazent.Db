-- functions/20261116_173507_update_company.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:35:07 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.update_company(p_id uuid, p_name character varying, p_plan smallint)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_id uuid;
BEGIN
    UPDATE public.companies
    SET
        name = COALESCE(p_name, name),
        plan = COALESCE(p_plan, plan),
        updated_at = NOW()
    WHERE id = p_id
    RETURNING id INTO v_id;

    RETURN v_id;
END;
$function$;
