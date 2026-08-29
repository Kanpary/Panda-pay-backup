import { NextResponse } from 'next/server'
import { getSupabaseServerClient } from '../../../../lib/supabase-server'

export async function POST(request: Request) {
  try {
    const body = await request.json().catch(() => ({}))
    const email = typeof body.email === 'string' ? body.email.trim().toLowerCase() : ''
    const password = typeof body.password === 'string' ? body.password : ''
    const username = typeof body.username === 'string' ? body.username.trim() : ''
    // O front-end envia estes campos (visível no bundle público), mas a rota
    // original descartava todos eles silenciosamente. Corrigido para
    // repassá-los como metadata do usuário no Supabase Auth.
    const fullName = typeof body.full_name === 'string' ? body.full_name.trim() : ''
    const phone = typeof body.phone === 'string' ? body.phone.trim() : ''
    const cpf = typeof body.cpf === 'string' ? body.cpf.replace(/\D/g, '') : ''
    const referredBy = typeof body.referred_by === 'string' ? body.referred_by.trim() : ''

    if (!email || !password) {
      return NextResponse.json({ success: false, error: 'E-mail e senha são obrigatórios.' }, { status: 400 })
    }
    if (password.length < 6) {
      return NextResponse.json({ success: false, error: 'A senha deve ter pelo menos 6 caracteres.' }, { status: 400 })
    }

    const metadata: Record<string, string> = {}
    if (username) metadata.username = username
    if (fullName) metadata.full_name = fullName
    if (phone) metadata.phone = phone
    if (cpf) metadata.cpf = cpf
    if (referredBy) metadata.referred_by = referredBy

    const supabase = await getSupabaseServerClient()
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: Object.keys(metadata).length ? { data: metadata } : undefined,
    })
    if (error) return NextResponse.json({ success: false, error: error.message }, { status: 400 })

    // Se a confirmação de e-mail estiver desativada no projeto Supabase,
    // data.session já vem preenchido e o cliente acima grava o cookie
    // automaticamente (login automático). Se a confirmação estiver ativada,
    // session vem null — nesse caso o cadastro é criado, mas o usuário
    // precisa confirmar o e-mail antes de logar, o que é sinalizado abaixo.
    return NextResponse.json({
      success: true,
      user: data.user,
      session: data.session,
      data: { user: data.user, session: data.session },
      requiresEmailConfirmation: !data.session,
      error: null,
    })
  } catch (error) {
    console.error('[auth/register] erro inesperado', error)
    return NextResponse.json({ success: false, error: 'Não foi possível conectar à API de autenticação.' }, { status: 500 })
  }
}
