import { r as d, t as f, W as r, j as e, C as l, x as m, y as u, w as p, v as i, I as c, B as x, V as _ } from "./index-DznaCJH5.js";
import { S as j } from "./switch-3mVuTb6z.js";

const n = (s, t = 0) => {
  const o = Number(s);
  return Number.isFinite(o) ? o : t;
};

const b = (s) =>
  typeof s == "boolean"
    ? s
    : typeof s == "number"
      ? s === 1
      : typeof s == "string"
        ? ["1", "true", "yes", "on"].includes(s.toLowerCase())
        : !1;

const g = (s) => {
  if (!s || typeof s != "object") return 0;
  const t = s.minimum_withdrawal_amount;
  if (Number.isFinite(Number(t))) return Number(t);
  const o = Number(s.min_withdrawal_player);
  const a = Number(s.min_withdrawal_affiliate);
  return Math.max(Number.isFinite(o) ? o : 0, Number.isFinite(a) ? a : 0);
};

const C = () => {
  const [s, t] = d.useState(null);

  d.useEffect(() => {
    void o();
  }, []);

  const o = async () => {
    try {
      const a = await f("/admin/financial-settings");
      const h = a.settings || {};
      t({ ...h, minimum_withdrawal_amount: g(h) });
    } catch (a) {
      r.error((a == null ? void 0 : a.message) || "Erro ao carregar configuracoes financeiras");
    }
  };

  const h = async () => {
    if (!s) return;
    try {
      await _("/admin/financial-settings", {
        min_deposit: n(s.min_deposit),
        minimum_withdrawal_amount: n(s.minimum_withdrawal_amount),
        deposit_bonus_enabled: b(s.deposit_bonus_enabled),
        deposit_bonus_percent: n(s.deposit_bonus_percent),
        deposit_bonus_min_amount: n(s.deposit_bonus_min_amount)
      });
      r.success("Configuracoes financeiras salvas!");
      await o();
    } catch (a) {
      r.error((a == null ? void 0 : a.message) || "Erro ao salvar configuracoes financeiras");
    }
  };

  if (!s) return null;

  const y = [0, 10, 25, 50, 100];

  return e.jsxs("div", {
    className: "space-y-6",
    children: [
      e.jsx("h1", {
        className: "text-2xl md:text-3xl font-bold tracking-tight",
        children: "Configuracoes Financeiras"
      }),
      e.jsxs(l, {
        children: [
          e.jsx(m, {
            className: "pb-3",
            children: e.jsx(u, { className: "text-lg", children: "Deposito Minimo" })
          }),
          e.jsx(p, {
            className: "space-y-4",
            children: e.jsxs("div", {
              className: "space-y-4",
              children: [
                e.jsxs("div", {
                  children: [
                    e.jsx(i, {
                      className: "text-xs uppercase font-bold text-muted-foreground mb-1.5 block",
                      children: "Deposito Minimo do Jogador (R$)"
                    }),
                    e.jsx(c, {
                      type: "number",
                      className: "h-11 md:h-10",
                      value: n(s.min_deposit),
                      onChange: (a) => t({ ...s, min_deposit: Number(a.target.value) })
                    }),
                    e.jsx("p", {
                      className: "text-sm text-muted-foreground mt-1",
                      children: "Valor minimo global que um jogador pode depositar na plataforma."
                    })
                  ]
                }),
                e.jsxs("div", {
                  children: [
                    e.jsx(i, {
                      className: "text-xs uppercase font-bold text-muted-foreground mb-1.5 block",
                      children: "Saque Minimo Jogador/Afiliado (R$)"
                    }),
                    e.jsx(c, {
                      type: "number",
                      className: "h-11 md:h-10",
                      value: n(s.minimum_withdrawal_amount),
                      onChange: (a) => t({ ...s, minimum_withdrawal_amount: Number(a.target.value) })
                    }),
                    e.jsx("p", {
                      className: "text-sm text-muted-foreground mt-1",
                      children: "Este valor unico controla o saque minimo do jogador e do afiliado."
                    })
                  ]
                })
              ]
            })
          })
        ]
      }),
      e.jsxs(l, {
        children: [
          e.jsx(m, {
            className: "pb-3",
            children: e.jsx(u, { className: "text-lg", children: "Bonus de Deposito" })
          }),
          e.jsxs(p, {
            className: "space-y-4",
            children: [
              e.jsxs("div", {
                className: "flex items-center gap-3",
                children: [
                  e.jsx(i, { children: "Bonus Ativo" }),
                  e.jsx(j, {
                    checked: b(s.deposit_bonus_enabled),
                    onCheckedChange: (a) => t({ ...s, deposit_bonus_enabled: a })
                  })
                ]
              }),
              e.jsxs("div", {
                className: "grid grid-cols-1 md:grid-cols-2 gap-4",
                children: [
                  e.jsxs("div", {
                    children: [
                      e.jsx(i, {
                        className: "text-xs uppercase font-bold text-muted-foreground mb-1.5 block",
                        children: "Porcentagem do Bonus (%)"
                      }),
                      e.jsx(c, {
                        type: "number",
                        className: "h-11 md:h-10",
                        value: n(s.deposit_bonus_percent),
                        onChange: (a) => t({ ...s, deposit_bonus_percent: Number(a.target.value) })
                      })
                    ]
                  }),
                  e.jsxs("div", {
                    children: [
                      e.jsx(i, {
                        className: "text-xs uppercase font-bold text-muted-foreground mb-1.5 block",
                        children: "Valor Minimo para Bonus (R$)"
                      }),
                      e.jsx(c, {
                        type: "number",
                        className: "h-11 md:h-10",
                        value: n(s.deposit_bonus_min_amount),
                        onChange: (a) => t({ ...s, deposit_bonus_min_amount: Number(a.target.value) })
                      })
                    ]
                  })
                ]
              }),
              e.jsx("div", {
                className: "flex flex-wrap gap-2 pt-2",
                children: y.map((a) =>
                  e.jsxs(
                    x,
                    {
                      variant: n(s.deposit_bonus_percent) === a ? "default" : "outline",
                      size: "sm",
                      className: "flex-1 min-w-[60px] h-10",
                      onClick: () => t({ ...s, deposit_bonus_percent: a }),
                      children: [a, "%"]
                    },
                    a
                  )
                )
              }),
              e.jsx("p", {
                className: "text-sm text-muted-foreground",
                children:
                  "Ex: Se o bonus for 100% e o valor minimo for R$30, um deposito de R$10 sera aceito mas nao ganhara bonus. Um deposito de R$30 ganhara R$30 extras."
              }),
              e.jsx(x, {
                onClick: () => void h(),
                className: "w-full h-12 md:h-11 font-bold mt-4",
                children: "Salvar Configuracoes"
              })
            ]
          })
        ]
      })
    ]
  });
};

export { C as default };
