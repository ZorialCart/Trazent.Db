-- functions/20261116_174420_assign_site_user.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:44:20 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.assign_site_user(
    p_site_id uuid,
    p_user_id uuid,
    p_assigned_by_id uuid,
    p_company_id uuid DEFAULT NULL
) RETURNS uuid
    LANGUAGE plpgsql
AS $function$
DECLARE
    v_id uuid;
BEGIN
    INSERT INTO public.site_assignments (site_id, user_id, assigned_by_id)
    VALUES (p_site_id, p_user_id, p_assigned_by_id)
    ON CONFLICT (site_id, user_id) DO NOTHING
    RETURNING id INTO v_id;

    IF v_id IS NULL THEN
        SELECT sa.id INTO v_id
          FROM public.site_assignments sa
         WHERE sa.site_id = p_site_id AND sa.user_id = p_user_id;
    END IF;

    RETURN v_id;
END;
$function$;
