-- functions/20261116_173753_change_company_status_by_id.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:37:53 PM
--
-- Write your SQL below

CREATE OR REPLACE FUNCTION public.change_company_status_by_id(p_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE 
	status boolean;
BEGIN 
	UPDATE companies SET
	is_active = NOT is_active
WHERE id = p_id
 	RETURNING is_active INTO status;
	 return STATUS;
END;
$function$;
