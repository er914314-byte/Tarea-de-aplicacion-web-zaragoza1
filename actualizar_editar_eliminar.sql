
ALTER TABLE public.registros_cursos
ADD COLUMN IF NOT EXISTS cliente_id uuid DEFAULT gen_random_uuid();

CREATE UNIQUE INDEX IF NOT EXISTS registros_cursos_cliente_id_idx
ON public.registros_cursos(cliente_id);

ALTER TABLE public.registros_cursos ENABLE ROW LEVEL SECURITY;


DROP POLICY IF EXISTS "Practica consultar registros" ON public.registros_cursos;
DROP POLICY IF EXISTS "Practica editar registros" ON public.registros_cursos;
DROP POLICY IF EXISTS "Practica eliminar registros" ON public.registros_cursos;

CREATE POLICY "Practica consultar registros"
ON public.registros_cursos FOR SELECT TO anon USING (true);

CREATE POLICY "Practica editar registros"
ON public.registros_cursos FOR UPDATE TO anon
USING (true) WITH CHECK (status = 'online');

CREATE POLICY "Practica eliminar registros"
ON public.registros_cursos FOR DELETE TO anon USING (true);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.registros_cursos TO anon;
GRANT USAGE ON SCHEMA public TO anon;

