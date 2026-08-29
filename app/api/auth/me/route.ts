import { NextResponse } from 'next/server'
import { getSupabaseServerClient, isAdminUser } from '../../../../lib/supabase-server'

// Esta rota é chamada pelo AuthContext do jogo (bundle público) logo após
// /api/auth/session confirmar que existe sessão, mas o arquivo não existia
// no backend (a chamada retornava 404 e o app tratava como erro de login).
export async function GET() {
  try {
    const supabase = await getSupabaseServerClient()
    const { data, error } = await supabase.auth.getUser()
    if (error || !data.user) {
      return NextResponse.json({ success: false, user: null, error: 'Não autenticado.' }, { status: 401 })
    }

    const user = { ...data.user, is_admin: isAdminUser(data.user) }
    return NextResponse.json(
      { success: true, user, data: { user }, error: null },
      { headers: { 'Cache-Control': 'no-store' } },
    )
  } catch (error) {
    console.error('[auth/me] erro inesperado', error)
    return NextResponse.json({ success: false, user: null, error: 'Não foi possível obter o usuário.' }, { status: 500 })
  }
}
