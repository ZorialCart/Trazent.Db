-- migrations/20261116_170608_create_site_assignments.sql
-- Author: ZorialCart
-- Date: Mon, Nov 16, 2026  5:06:08 PM
--
-- Write your SQL below

CREATE TABLE public.site_assignments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    site_id uuid NOT NULL,
    user_id uuid NOT NULL,
    assigned_by_id uuid NOT NULL,
    assigned_at timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE public.site_assignments OWNER TO postgres;

ALTER TABLE ONLY public.site_assignments
    ADD CONSTRAINT pk_site_assignments PRIMARY KEY (id);

ALTER TABLE ONLY public.site_assignments
    ADD CONSTRAINT uq_site_assignments_site_user UNIQUE (site_id, user_id);

CREATE INDEX ix_site_assignments_user_id ON public.site_assignments USING btree (user_id);
CREATE INDEX ix_site_assignments_assigned_by_id ON public.site_assignments USING btree (assigned_by_id);

ALTER TABLE ONLY public.site_assignments
    ADD CONSTRAINT fk_site_assignments_site
    FOREIGN KEY (site_id) REFERENCES public.sites(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.site_assignments
    ADD CONSTRAINT fk_site_assignments_user
    FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.site_assignments
    ADD CONSTRAINT fk_site_assignments_assigned_by
    FOREIGN KEY (assigned_by_id) REFERENCES public.users(id) ON DELETE RESTRICT;

COMMENT ON TABLE public.site_assignments IS 'Asignación de usuarios a sitios. Define en qué sitios puede registrar asistencia un contratista y qué sitios puede supervisar un supervisor.';
COMMENT ON COLUMN public.site_assignments.id IS 'Identificador único de la asignación.';
COMMENT ON COLUMN public.site_assignments.site_id IS 'Sitio asignado.';
COMMENT ON COLUMN public.site_assignments.user_id IS 'Contratista o supervisor asignado al sitio (único por sitio).';
COMMENT ON COLUMN public.site_assignments.assigned_by_id IS 'Administrador o supervisor que hizo la asignación (auditoría).';
COMMENT ON COLUMN public.site_assignments.assigned_at IS 'Fecha en que se hizo la asignación.';