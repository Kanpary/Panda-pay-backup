import { getSupabaseAdminClient } from './supabase-server'

export async function getOnixPaySandbox() {
  try {
    const admin = getSupabaseAdminClient()
    const { data, error } = await admin
      .from('app_settings')
      .select('value')
      .eq('key', 'onixpay_sandbox')
      .maybeSingle()
    if (error || !data) return false
    return data.value === true || data.value === 'true'
  } catch {
    return false
  }
}

export function getOnixPayUrl(sandbox: boolean) {
  return sandbox
    ? process.env.ONIXPAY_SANDBOX_API_URL ?? 'https://onixpay.space/api/v2'
    : process.env.ONIXPAY_API_URL ?? 'https://onixpay.space/api/v2'
}

export function getOnixPayCredentials() {
  return { client_id: process.env.ONIXPAY_CLIENT_ID, client_secret: process.env.ONIXPAY_CLIENT_SECRET }
}
