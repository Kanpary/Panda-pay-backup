import { NextResponse } from 'next/server'
import { updateDepositFromWebhook } from '../../../../lib/onixpay-db'

export async function POST(request: Request) {
  const raw = await request.text()
  const signature = request.headers.get('x-onixpay-signature')
  const expected = process.env.ONIXPAY_WEBHOOK_SECRET
  if (expected && signature && signature !== expected) return NextResponse.json({ message: 'Webhook inválido.' }, { status: 401 })

  try {
    const payload = JSON.parse(raw) as Record<string, unknown>
    const transactionId = String(payload.idTransaction ?? payload.transaction_id ?? payload.transactionId ?? '')
    const status = String(payload.status ?? payload.payment_status ?? 'pending')
    if (!transactionId) return NextResponse.json({ message: 'transaction_id ausente.' }, { status: 400 })
    await updateDepositFromWebhook(transactionId, status, payload)
    return NextResponse.json({ received: true })
  } catch (error) {
    console.error('[v0] OnixPay webhook error', error)
    return NextResponse.json({ message: 'Webhook inválido.' }, { status: 400 })
  }
}
