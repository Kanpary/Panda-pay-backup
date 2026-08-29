import { createServerClient } from '@supabase/ssr'
import { createClient, type User } from '@supabase/supabase-js'
import { cookies } from 'next/headers'

/**
 * Antes desta correção, cada rota lia as variáveis de ambiente do Supabase
 * com uma combinação diferente de nomes (ex.: app/api/auth/login usava
 * SUPABASE_ANON_KEY, enquanto app/api/admin/login usava apenas
 * NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY). Isso fazia com que login funcionasse
 * em um fluxo e falhasse em outro, dependendo de qual variável estava
 * configurada na Vercel. Centralizamos aqui a mesma cadeia de fallback para
 * todas as rotas.
 */
export function getSupabaseUrl() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL ?? process.env.SUPABASE_URL
  if (!url) throw new Error('Supabase URL configuration is missing')
  return url
}

export function getSupabaseAnonKey() {
  const key =
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ??
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY ??
    process.env.SUPABASE_ANON_KEY ??
    process.env.SUPABASE_PUBLISHABLE_KEY
  if (!key) throw new Error('Supabase anon key configuration is missing')
  return key
}

export function getSupabaseServiceKey() {
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY ?? process.env.SUPABASE_SECRET_KEY
  if (!key) throw new Error('Supabase service role key configuration is missing')
  return key
}

/**
 * Cliente com contexto de cookies do Next.js. É o único cliente que deve ser
 * usado nas rotas de autenticação de usuário (login, registro, sessão, me,
 * logout), pois é ele quem efetivamente grava/lê/apaga o cookie de sessão no
 * navegador. Sem isso, o login "funciona" mas a sessão nunca persiste
 * (era exatamente o bug original).
 */
export async function getSupabaseServerClient() {
  const cookieStore = await cookies()
  return createServerClient(getSupabaseUrl(), getSupabaseAnonKey(), {
    cookies: {
      getAll: () => cookieStore.getAll(),
      setAll: values => {
        values.forEach(({ name, value, options }) => cookieStore.set(name, value, options))
      },
    },
  })
}

/**
 * Cliente com a service role key, sem cookies. Uso restrito a operações de
 * administração/backend (ex.: alternar sandbox, ler/gravar tabelas com
 * privilégio total). Nunca deve ser exposto ao navegador.
 */
export function getSupabaseAdminClient() {
  return createClient(getSupabaseUrl(), getSupabaseServiceKey(), {
    auth: { autoRefreshToken: false, persistSession: false },
  })
}

/**
 * Critério único de "é admin". Antes só existia dentro de
 * app/api/admin/settings/route.ts; centralizado aqui para que
 * app/api/auth/me use exatamente a mesma regra.
 */
export function isAdminUser(user: Pick<User, 'app_metadata' | 'email'> | null | undefined) {
  if (!user) return false
  return user.app_metadata?.role === 'admin' || user.email === 'detroit.system@gmail.com'
}
