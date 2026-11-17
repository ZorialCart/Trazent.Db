-- functions/20261116_173422_revoke_user_refresh_tokens.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:34:22 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.revoke_user_refresh_tokens(
    p_id uuid
) RETURNS integer
    LANGUAGE plpgsql
AS $function$
DECLARE
    v_updated integer;
BEGIN
    UPDATE public.refresh_tokens r
       SET revoked_at = now()
     WHERE r.user_id = p_id AND r.revoked_at IS NULL;
    GET DIAGNOSTICS v_updated = ROW_COUNT;
    RETURN v_updated;
END;
$function$;
