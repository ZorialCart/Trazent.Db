-- functions/20261116_172434_delete_stale_device_tokens.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:24:34 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.delete_stale_device_tokens(
    p_days integer DEFAULT 90
) RETURNS integer
    LANGUAGE plpgsql
AS $function$
DECLARE
    v_deleted integer;
BEGIN
    DELETE FROM public.device_tokens d
     WHERE d.last_seen_at < now() - make_interval(days => COALESCE(p_days, 90));
    GET DIAGNOSTICS v_deleted = ROW_COUNT;
    RETURN v_deleted;
END;
$function$;
