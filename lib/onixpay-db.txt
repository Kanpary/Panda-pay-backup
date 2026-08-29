import { getSupabaseAdminClient } from './supabase-server'

export async function insertDeposit(input: {
  userId: string
  amount: number
  transactionId: string | null
  externalId: string | null
  pixCode: string | null
  response: unknown
}) {
  const admin = getSupabaseAdminClient()
  const { error } = await admin.from('deposits').insert({
    user_id: input.userId,
    amount: input.amount,
    gateway: 'onixpay',
    external_id: input.externalId,
    txid: input.transactionId,
    qrcode: input.pixCode,
    metadata: input.response,
    status: 'pending',
  })
  if (error) throw new Error(`Supabase deposit insert failed: ${error.message}`)
}

export async function updateDepositFromWebhook(transactionId: string, status: string, payload: unknown) {
  const normalized = status.toLowerCase() === 'paid' ? 'paid' : status.toLowerCase() === 'failed' ? 'failed' : 'pending'
  const admin = getSupabaseAdminClient()
  const { error } = await admin
    .from('deposits')
    .update({
      status: normalized,
      response: payload,
      ...(normalized === 'paid' ? { paid_at: new Date().toISOString() } : {}),
    })
    .eq('txid', transactionId)
  if (error) throw new Error(`Supabase deposit update failed: ${error.message}`)
}
