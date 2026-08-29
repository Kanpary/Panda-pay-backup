'use client'

import { useEffect, useState } from 'react'
import { getSupabaseBrowser } from '../../lib/supabase-browser'

export default function AdminPage() {
  const [supabase, setSupabase] = useState<ReturnType<typeof getSupabaseBrowser> | null>(null)
  const [session, setSession] = useState<any>(null)
  const [email, setEmail] = useState('detroit.system@gmail.com')
  const [password, setPassword] = useState('')
  const [sandbox, setSandbox] = useState(false)
  const [error, setError] = useState('')
  const [busy, setBusy] = useState(false)

  useEffect(() => {
    const browser = getSupabaseBrowser()
    setSupabase(browser)
    let active = true
    browser.auth.getSession().then(({ data }) => { if (active) setSession(data.session) })
    const { data: listener } = browser.auth.onAuthStateChange((_event, nextSession) => {
      if (active) setSession(nextSession)
    })
    return () => { active = false; listener.subscription.unsubscribe() }
  }, [])
  useEffect(() => {
    if (!session) return
    fetch('/api/admin/settings', { headers: { Authorization: `Bearer ${session.access_token}` } }).then(r => r.json()).then(d => setSandbox(d.sandbox ?? true))
  }, [session])

  async function login(event?: React.FormEvent<HTMLFormElement>) {
    event?.preventDefault()
    setBusy(true); setError('')
    const browser = supabase ?? getSupabaseBrowser()
    const form = event?.currentTarget
    const formData = form ? new FormData(form) : null
    const loginEmail = String(formData?.get('email') ?? email).trim()
    const loginPassword = String(formData?.get('password') ?? password)
    const response = await fetch('/api/admin/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ email: loginEmail, password: loginPassword }),
    })
    const result = await response.json().catch(() => ({}))
    if (!response.ok || !result.session) {
      setError(result.message ?? 'E-mail ou senha inválidos.')
    } else {
      const { error: sessionError } = await browser.auth.setSession(result.session)
      if (sessionError) setError('Não foi possível iniciar a sessão.')
      else setSession(result.session)
    }
    setBusy(false)
  }

  async function toggle(next: boolean) {
    if (!next && !window.confirm('Você está mudando para PRODUÇÃO. As próximas operações poderão movimentar dinheiro real. Continuar?')) return
    setBusy(true); setError('')
    const response = await fetch('/api/admin/settings', { method: 'POST', headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` }, body: JSON.stringify({ sandbox: next }) })
    if (!response.ok) setError('Não foi possível alterar o ambiente.')
    else setSandbox(next)
    setBusy(false)
  }

  if (!session) return <main className="admin-page"><section className="admin-login"><p className="eyebrow">POU ONIX · ADMIN</p><h1>Acesso administrativo</h1><form action="/api/admin/login" method="post" onSubmit={event => void login(event)}><label>E-mail<input name="email" value={email} onChange={event => setEmail(event.target.value)} type="email" required autoComplete="email" /></label><label>Senha<input name="password" value={password} onChange={event => setPassword(event.target.value)} type="password" required autoComplete="current-password" /></label>{error && <p className="admin-error">{error}</p>}<button type="submit" disabled={busy}>{busy ? 'Entrando...' : 'Entrar no painel'}</button></form></section></main>

  return <main className="admin-page"><header className="admin-header"><div><p className="eyebrow">POU ONIX · CONTROLE</p><h1>Painel administrativo</h1></div><button className="secondary" onClick={() => supabase.auth.signOut()}>Sair</button></header><section className="admin-grid"><article className="admin-card environment-card"><div><p className="eyebrow">ONIXPAY</p><h2>Ambiente de pagamentos</h2><p className="muted">Escolha onde depósitos e saques serão processados.</p></div><label className="sandbox-toggle"><input type="checkbox" checked={sandbox} disabled={busy} onChange={e => toggle(e.target.checked)} /><span>{sandbox ? 'Sandbox ativo' : 'Produção ativa'}</span></label><p className={sandbox ? 'status safe' : 'status danger'}>{sandbox ? 'Modo seguro para testes. Nenhum dinheiro real será movimentado.' : 'Modo produção. Operações financeiras reais estão habilitadas.'}</p></article><article className="admin-card"><p className="eyebrow">VISÃO GERAL</p><h2>Operações</h2><div className="metric-row"><span>Depósitos</span><strong>Prontos para consulta</strong></div><div className="metric-row"><span>Saques</span><strong>Controle server-side</strong></div><div className="metric-row"><span>Jogo Pou</span><strong>Sessões protegidas</strong></div></article></section>{error && <p className="admin-error">{error}</p>}</main>
}
