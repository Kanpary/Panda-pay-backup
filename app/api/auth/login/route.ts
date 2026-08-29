import { NextResponse } from 'next/server'
import { getSupabaseServerClient } from '../../../../lib/supabase-server'

export async function POST(request: Request) {
  try {
    const body = await request.json().catch(() => ({}))
    const email = typeof body.email === 'string' ? body.email.trim().toLowerCase() : ''
    const password = typeof body.password === 'string' ? body.password : ''
    if (!email || !password) {
      return NextResponse.json({ success: false, error: 'E-mail e senha são obrigatórios.' }, { status: 400 })
    }

    // Cliente com cookies: é o que faz a sessão realmente persistir entre
    // requisições. O bug original usava um cliente sem persistência e a
    // sessão nunca ficava salva, mesmo com o login "dando certo".
    const supabase = await getSupabaseServerClient()
    const { data, error } = await supabase.auth.signInWithPassword({ email, password })
    if (error || !data.user || !data.session) {
      return NextResponse.json({ success: false, error: error?.message ?? 'Credenciais inválidas.' }, { status: 401 })
    }

    return NextResponse.json({ success: true, user: data.user, session: data.session, data: { user: data.user, session: data.session }, error: null })
  } catch (error) {
    console.error('[auth/login] erro inesperado', error)
    return NextResponse.json({ success: false, error: 'Não foi possível conectar à API de autenticação.' }, { status: 500 })
  }
}
