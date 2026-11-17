-- functions/20261116_173451_unassign_site_user.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:34:51 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.unassign_site_user(
    p_site_id uuid,
    p_user_id uuid,
    p_company_id uuid DEFAULT NULL
) RETURNS boolean
    LANGUAGE plpgsql
AS $function$
DECLARE
    v_deleted integer;
BEGIN
    DELETE FROM public.site_assignments sa
     WHERE sa.site_id = p_site_id AND sa.user_id = p_user_id;
    GET DIAGNOSTICS v_deleted = ROW_COUNT;

    RETURN v_deleted > 0;
END;
$function$;
