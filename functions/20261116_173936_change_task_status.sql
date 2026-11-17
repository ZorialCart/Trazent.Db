-- functions/20261116_173936_change_task_status.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:39:36 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.change_task_status(
    p_id uuid,
    p_company_id uuid DEFAULT NULL,
    p_changed_by_id uuid DEFAULT NULL,
    p_status smallint DEFAULT 0
) RETURNS smallint
    LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.tasks t
       SET status = p_status,
           completed_at = CASE WHEN p_status = 2 THEN now() ELSE NULL END,
           updated_at = NOW()
     WHERE t.id = p_id
       AND (p_company_id IS NULL OR t.company_id = p_company_id);

    RETURN p_status;
END;
$function$;
