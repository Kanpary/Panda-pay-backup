import { NextResponse } from 'next/server'
import { getSupabaseServerClient } from '../../../../lib/supabase-server'

// Chamada pelo signOut() do AuthContext (bundle público); também não
// existia no backend, então o botão de sair nunca limpava a sessão de fato.
export async function POST() {
  try {
    const supabase = await getSupabaseServerClient()
    const { error } = await supabase.auth.signOut()
    if (error) return NextResponse.json({ success: false, error: error.message }, { status: 500 })
    return NextResponse.json({ success: true, error: null })
  } catch (error) {
    console.error('[auth/logout] erro inesperado', error)
    return NextResponse.json({ success: false, error: 'Não foi possível encerrar a sessão.' }, { status: 500 })
  }
}
