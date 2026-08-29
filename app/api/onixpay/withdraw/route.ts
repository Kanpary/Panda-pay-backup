import { NextResponse } from 'next/server'
import { getOnixPayCredentials, getOnixPaySandbox, getOnixPayUrl } from '../../../../lib/onixpay-environment'

function digits(value: unknown) {
  return typeof value === 'string' ? value.replace(/\D/g, '') : ''
}

function text(value: unknown, fallback: string) {
  return typeof value === 'string' && value.trim() ? value.trim() : fallback
}

export async function POST(request: Request) {
  try {
    const body = await request.json()
    const userId = typeof body.user_id === 'string' ? body.user_id.trim() : ''
    const amount = Number(body.amount)
    const pixKey = text(body.pix_key, '')
    const name = text(body.nome, 'Cliente')
    const cpf = digits(body.cpf)

    if (!userId || !Number.isFinite(amount) || amount <= 0 || !pixKey || !name || cpf.length !== 11) {
      return NextResponse.json({ message: 'user_id, amount, nome, cpf e pix_key são obrigatórios.' }, { status: 400 })
    }

    const sandbox = await getOnixPaySandbox()
    const { client_id, client_secret } = getOnixPayCredentials()
    if (!client_id || !client_secret) {
      return NextResponse.json({ message: 'Credenciais OnixPay não configuradas.' }, { status: 503 })
    }
    const payload = new URLSearchParams({
      client_id,
      client_secret,
      nome: name,
      cpf,
      valor: amount.toFixed(2),
      chave_pix: pixKey,
      descricao: text(body.descricao, 'Saque Pix'),
      urlnoty: `${new URL(request.url).origin}/api/onixpay/webhook`,
    }).toString()
    const response = await fetch(`${getOnixPayUrl(sandbox)}/pix/payment.php`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: payload,
      cache: 'no-store',
    })
    const data = await response.json().catch(() => ({}))
    if (!response.ok) return NextResponse.json(data, { status: response.status })
    return NextResponse.json(data)
  } catch (error) {
    console.error('[v0] OnixPay withdraw error', error)
    return NextResponse.json({ message: 'Não foi possível solicitar o saque.' }, { status: 500 })
  }
}
