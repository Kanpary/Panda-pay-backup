import { NextResponse } from 'next/server'
import { getSupabaseServerClient } from '../../../../lib/supabase-server'

export async function GET() {
  try {
    // A versão original ignorava por completo o cookie e retornava sempre
    // { authenticated: false }. Por isso, mesmo após um login bem-sucedido,
    // o app achava que o usuário nunca estava logado.
    const supabase = await getSupabaseServerClient()
    const { data, error } = await supabase.auth.getSession()
    const session = error ? null : data.session

    const payload = { authenticated: !!session, user: session?.user ?? null, session }

    // Mantém o formato legado e o formato { data } esperado pelo jogo.
    return NextResponse.json(
      { success: true, ...payload, data: payload, error: null },
      { headers: { 'Cache-Control': 'no-store' } },
    )
  } catch (error) {
    console.error('[auth/session] erro inesperado', error)
    const payload = { authenticated: false, user: null, session: null }
    return NextResponse.json(
      { success: false, ...payload, data: payload, error: 'Não foi possível verificar a sessão.' },
      { status: 500, headers: { 'Cache-Control': 'no-store' } },
    )
  }
}
