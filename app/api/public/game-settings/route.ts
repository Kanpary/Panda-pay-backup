import { NextResponse } from 'next/server'

export async function GET() {
  return NextResponse.json({ success: true, settings: {} }, { headers: { 'Cache-Control': 'no-store' } })
}
