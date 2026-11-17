-- functions/20261116_173324_reset_login_failures.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:33:24 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.reset_login_failures(
    p_id uuid
) RETURNS void
    LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.users u
       SET access_failed_count = 0,
           lockout_end = NULL
     WHERE u.id = p_id
       AND (u.access_failed_count <> 0 OR u.lockout_end IS NOT NULL);
END;
$function$;
