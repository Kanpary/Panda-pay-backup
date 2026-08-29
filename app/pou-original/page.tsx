import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Pou',
  description: 'Jogo Pou.',
}

export default function PouOriginalPage() {
  return (
    <main className="pou-shell" style={{ height: '100vh', width: '100vw', overflow: 'hidden' }}>
      <iframe
        title="Jogo do Pou"
        src="/pou-game"
        className="original-frame"
        style={{ display: 'block', height: '100%', width: '100%', border: 0 }}
      />
    </main>
  )
}
