import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Pou Onix',
  description: 'Aplicação original do Pou Onix.',
}

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="pt-BR" className="bg-white"><body>{children}</body></html>
}
