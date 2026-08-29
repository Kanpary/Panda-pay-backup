import { r as l, t as _, W as d, j as e, C as x, x as h, y as v, w as j, v as r, I as o, B as g, V as N } from "./index-DznaCJH5.js";
import { S as f } from "./switch-3mVuTb6z.js";

const i = (s, t = 0) => {
  const n = Number(s);
  return Number.isFinite(n) ? n : t;
};

const c = (s) =>
  typeof s == "boolean"
    ? s
    : typeof s == "number"
      ? s === 1
      : typeof s == "string"
        ? ["1", "true", "yes", "on"].includes(s.toLowerCase())
        : !1;

const a = (s) => Math.min(10, Math.max(0, Math.round(i(s))));

const b = () => {
  const [s, t] = l.useState(null);
  const [n, m] = l.useState(!1);

  l.useEffect(() => {
    void u();
  }, []);

  const u = async () => {
    try {
      const p = await _("/admin/commission-settings");
      t(p.settings || {});
    } catch (p) {
      d.error((p == null ? void 0 : p.message) || "Erro ao carregar configuracoes");
    }
  };

  const C = async () => {
    if (!s) return;
    m(!0);
    try {
      await N("/admin/commission-settings", {
        default_commission_percent: i(s.default_commission_percent),
        default_commission_percent_level2: i(s.default_commission_percent_level2),
        first_deposit_only: c(s.first_deposit_only),
        min_deposit_for_commission: i(s.min_deposit_for_commission),
        affiliate_skip_interval: a(s.affiliate_skip_interval),
        is_active: c(s.is_active)
      });
      d.success("Configuracoes de comissao salvas!");
      await u();
    } catch (p) {
      d.error((p == null ? void 0 : p.message) || "Erro ao salvar alteracoes");
    } finally {
      m(!1);
    }
  };

  if (!s) {
    return e.jsx("div", {
      className: "flex items-center justify-center h-48",
      children: e.jsx("p", { className: "text-muted-foreground", children: "Carregando configuracoes..." })
    });
  }

  const k = a(s.affiliate_skip_interval);
  const y = k === 0
    ? "Desativado"
    : k === 1
      ? "Conta 1 CPA elegivel e pula o proximo"
      : `Conta ${k} CPAs elegiveis e pula o proximo`;

  return e.jsxs("div", {
    className: "space-y-6",
    children: [
      e.jsx("h1", { className: "text-2xl font-bold", children: "Configuracoes de Comissao" }),
      e.jsxs(x, {
        children: [
          e.jsx(h, { children: e.jsx(v, { children: "CPA e Afiliados" }) }),
          e.jsxs(j, {
            className: "space-y-4",
            children: [
              e.jsxs("div", {
                className: "space-y-3 py-2 border-b",
                children: [
                  e.jsxs("div", {
                    className: "space-y-0.5",
                    children: [
                      e.jsx("p", { className: "text-sm font-medium", children: "Comissao ativa para todos os depositos" }),
                      e.jsx("p", {
                        className: "text-xs text-muted-foreground",
                        children: c(s.first_deposit_only)
                          ? "Com a regra de primeiro deposito ligada, somente o primeiro deposito valido do indicado gera CPA."
                          : "Com a regra de primeiro deposito desligada, todos os depositos validos podem gerar CPA."
                      })
                    ]
                  }),
                  e.jsxs("div", {
                    className: "flex items-center justify-between",
                    children: [
                      e.jsx(r, { htmlFor: "comm-active", className: "cursor-pointer", children: "Comissionamento Ativo" }),
                      e.jsx(f, {
                        id: "comm-active",
                        checked: c(s.is_active),
                        onCheckedChange: (p) => t({ ...s, is_active: p })
                      })
                    ]
                  })
                ]
              }),
              e.jsxs("div", {
                className: "grid grid-cols-1 md:grid-cols-2 gap-4 pt-2",
                children: [
                  e.jsxs("div", {
                    className: "space-y-2",
                    children: [
                      e.jsx(r, { children: "CPA Nivel 1 (%)" }),
                      e.jsx(o, {
                        type: "number",
                        min: "0",
                        max: "100",
                        value: i(s.default_commission_percent),
                        onChange: (p) => t({ ...s, default_commission_percent: Number(p.target.value) })
                      })
                    ]
                  }),
                  e.jsxs("div", {
                    className: "space-y-2",
                    children: [
                      e.jsx(r, { children: "CPA Nivel 2 (%)" }),
                      e.jsx(o, {
                        type: "number",
                        min: "0",
                        max: "100",
                        value: i(s.default_commission_percent_level2),
                        onChange: (p) => t({ ...s, default_commission_percent_level2: Number(p.target.value) })
                      })
                    ]
                  })
                ]
              }),
              e.jsxs("div", {
                className: "flex items-center justify-between py-2 border-b",
                children: [
                  e.jsx(r, { htmlFor: "first-dep", className: "cursor-pointer", children: "Somente primeiro deposito" }),
                  e.jsx(f, {
                    id: "first-dep",
                    checked: c(s.first_deposit_only),
                    onCheckedChange: (p) => t({ ...s, first_deposit_only: p })
                  })
                ]
              }),
              e.jsxs("div", {
                className: "space-y-2",
                children: [
                  e.jsx(r, { children: "Valor Minimo do Deposito para Gerar CPA (R$)" }),
                  e.jsx(o, {
                    type: "number",
                    min: "0",
                    value: i(s.min_deposit_for_commission),
                    onChange: (p) => t({ ...s, min_deposit_for_commission: Number(p.target.value) })
                  })
                ]
              }),
              e.jsxs("div", {
                className: "space-y-2 pt-4 border-t",
                children: [
                  e.jsx(r, { className: "text-base font-semibold", children: "Regra de Pular Indicacao (Anti-Fraude)" }),
                  e.jsx("p", {
                    className: "text-sm text-muted-foreground",
                    children: "Informe de 0 a 10. Se estiver 0, a regra fica desativada. Se estiver 2, por exemplo, contabiliza 2 CPAs elegiveis e pula o proximo."
                  }),
                  e.jsxs("div", {
                    className: "flex items-center gap-4",
                    children: [
                      e.jsx(o, {
                        type: "number",
                        min: "0",
                        max: "10",
                        className: "w-24",
                        value: k,
                        onChange: (p) => t({ ...s, affiliate_skip_interval: a(p.target.value) })
                      }),
                      e.jsx("span", { className: "text-sm", children: y })
                    ]
                  })
                ]
              }),
              e.jsx("div", {
                className: "pt-4",
                children: e.jsx(g, {
                  onClick: () => void C(),
                  className: "w-full",
                  disabled: n,
                  children: n ? "Salvando..." : "Salvar Alteracoes"
                })
              })
            ]
          })
        ]
      })
    ]
  });
};

export { b as default };
