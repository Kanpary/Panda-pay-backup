import { NextResponse } from 'next/server'

export async function GET(request: Request) {
  const transactionId = new URL(request.url).searchParams.get('transaction_id')
  if (!transactionId) return NextResponse.json({ message: 'transaction_id é obrigatório.' }, { status: 400 })
  const url = new URL('https://onixpay.space/api/v2/pix/status.php')
  url.searchParams.set('client_id', process.env.ONIXPAY_CLIENT_ID ?? '')
  url.searchParams.set('client_secret', process.env.ONIXPAY_CLIENT_SECRET ?? '')
  url.searchParams.set('transaction_id', transactionId)
  const response = await fetch(url, { cache: 'no-store' })
  const data = await response.json().catch(() => ({ message: 'Resposta inválida da OnixPay.' }))
  return NextResponse.json(data, { status: response.status })
}
