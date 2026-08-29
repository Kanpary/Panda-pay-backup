import { c as createIcon, r as React, t as apiGet, W as toast, j as jsxRuntime, C as Card, x as CardHeader, y as CardTitle, w as CardContent, v as Label, I as Input, B as Button, Z as apiPost, V as apiPut, Y as apiDelete } from "./index-DznaCJH5.js";
import { S as Switch } from "./switch-3mVuTb6z.js";
import { I as InfoIcon } from "./info-C5AhTPbx.js";
import { I as ImageIcon } from "./image-Cq8NNYd-.js";
import { T as TrashIcon } from "./trash-2-Bi4PlzjK.js";

const PlusIcon = createIcon("Plus", [
  ["path", { d: "M5 12h14", key: "plus-h" }],
  ["path", { d: "M12 5v14", key: "plus-v" }],
]);

const normalizeBool = (value) => {
  if (typeof value === "boolean") return value;
  if (typeof value === "number") return value === 1;
  if (typeof value === "string") return ["1", "true", "yes", "on"].includes(value.toLowerCase());
  return false;
};

const uploadBannerImage = async (file) => {
  const form = new FormData();
  form.append("file", file);

  const response = await fetch("/api/admin/banners/upload", {
    method: "POST",
    body: form,
    credentials: "include",
  });

  const json = await response.json().catch(() => null);
  if (!response.ok || !json || json.success !== true || !json.data?.url) {
    const message = json?.error || "Falha no upload da imagem";
    throw new Error(message);
  }

  return json.data;
};

const AdminBanners = () => {
  const [items, setItems] = React.useState([]);
  const [uploading, setUploading] = React.useState(false);
  const [form, setForm] = React.useState({
    title: "",
    subtitle: "",
    image_url: "",
    is_active: true,
    sort_order: 0,
  });
  const [rowUploadingId, setRowUploadingId] = React.useState(null);
  const createFileRef = React.useRef(null);
  const rowFileRef = React.useRef({});

  const loadItems = async () => {
    try {
      const response = await apiGet("/admin/banners");
      setItems(response.items || []);
    } catch (error) {
      toast.error(error?.message || "Erro ao carregar banners");
    }
  };

  React.useEffect(() => {
    loadItems();
  }, []);

  const handleCreateUpload = async (evt) => {
    const file = evt.target.files?.[0];
    evt.target.value = "";
    if (!file) return;
    try {
      setUploading(true);
      const uploaded = await uploadBannerImage(file);
      setForm((prev) => ({ ...prev, image_url: uploaded.url }));
      toast.success("Imagem enviada com sucesso");
    } catch (error) {
      toast.error(error?.message || "Erro ao enviar imagem");
    } finally {
      setUploading(false);
    }
  };

  const handleRowUpload = async (bannerId, evt) => {
    const file = evt.target.files?.[0];
    evt.target.value = "";
    if (!file) return;
    try {
      setRowUploadingId(bannerId);
      const uploaded = await uploadBannerImage(file);
      await apiPut(`/admin/banners/${bannerId}`, { image_url: uploaded.url });
      toast.success("Imagem atualizada");
      await loadItems();
    } catch (error) {
      toast.error(error?.message || "Erro ao atualizar imagem");
    } finally {
      setRowUploadingId(null);
    }
  };

  const createBanner = async () => {
    if (!form.image_url) {
      toast.error("Informe URL ou envie uma imagem");
      return;
    }
    try {
      await apiPost("/admin/banners", {
        title: form.title,
        subtitle: form.subtitle,
        image_url: form.image_url,
        is_active: form.is_active,
        sort_order: Number(form.sort_order) || 0,
      });
      toast.success("Banner adicionado");
      setForm({ title: "", subtitle: "", image_url: "", is_active: true, sort_order: 0 });
      await loadItems();
    } catch (error) {
      toast.error(error?.message || "Erro ao adicionar banner");
    }
  };

  const updateField = async (id, field, value) => {
    try {
      await apiPut(`/admin/banners/${id}`, { [field]: value });
      await loadItems();
    } catch (error) {
      toast.error(error?.message || "Erro ao atualizar banner");
    }
  };

  const removeBanner = async (id) => {
    try {
      await apiDelete(`/admin/banners/${id}`);
      toast.success("Banner removido");
      await loadItems();
    } catch (error) {
      toast.error(error?.message || "Erro ao remover banner");
    }
  };

  return jsxRuntime.jsxs("div", {
    className: "space-y-6 pb-10",
    children: [
      jsxRuntime.jsx("div", { className: "flex items-center justify-between", children: jsxRuntime.jsx("h1", { className: "text-2xl md:text-3xl font-bold tracking-tight", children: "Banners" }) }),
      jsxRuntime.jsxs(Card, {
        children: [
          jsxRuntime.jsx(CardHeader, { children: jsxRuntime.jsx(CardTitle, { children: "Adicionar Novo Banner" }) }),
          jsxRuntime.jsxs(CardContent, {
            className: "space-y-4",
            children: [
              jsxRuntime.jsxs("div", {
                className: "grid grid-cols-1 md:grid-cols-2 gap-4",
                children: [
                  jsxRuntime.jsxs("div", {
                    className: "space-y-4",
                    children: [
                      jsxRuntime.jsxs("div", { className: "space-y-2", children: [jsxRuntime.jsx(Label, { className: "text-xs uppercase font-bold text-muted-foreground", children: "Título (Opcional)" }), jsxRuntime.jsx(Input, { value: form.title, onChange: (e) => setForm({ ...form, title: e.target.value }), placeholder: "Ex: Novo lançamento", className: "h-11 md:h-10" })] }),
                      jsxRuntime.jsxs("div", { className: "space-y-2", children: [jsxRuntime.jsx(Label, { className: "text-xs uppercase font-bold text-muted-foreground", children: "Subtítulo (Opcional)" }), jsxRuntime.jsx(Input, { value: form.subtitle, onChange: (e) => setForm({ ...form, subtitle: e.target.value }), placeholder: "Ex: Jogue agora", className: "h-11 md:h-10" })] }),
                      jsxRuntime.jsxs("div", {
                        className: "space-y-2",
                        children: [
                          jsxRuntime.jsx(Label, { className: "text-xs uppercase font-bold text-muted-foreground", children: "Imagem do Banner" }),
                          jsxRuntime.jsx(Input, { value: form.image_url, onChange: (e) => setForm({ ...form, image_url: e.target.value }), placeholder: "https://...", className: "h-11 md:h-10" }),
                          jsxRuntime.jsxs("div", {
                            className: "flex items-center gap-2",
                            children: [
                              jsxRuntime.jsx("input", { ref: createFileRef, type: "file", accept: ".jpg,.jpeg,.png,.webp,.gif,image/jpeg,image/png,image/webp,image/gif", className: "hidden", onChange: (e) => void handleCreateUpload(e) }),
                              jsxRuntime.jsx(Button, { type: "button", variant: "outline", onClick: () => createFileRef.current?.click(), disabled: uploading, children: uploading ? "Enviando imagem..." : "Enviar imagem do PC" }),
                            ],
                          }),
                          jsxRuntime.jsxs("div", { className: "flex items-center gap-2 text-xs text-muted-foreground", children: [jsxRuntime.jsx(InfoIcon, { className: "h-4 w-4" }), "Aceita jpg, jpeg, png, webp e gif até 5MB."] }),
                        ],
                      }),
                    ],
                  }),
                  jsxRuntime.jsx("div", {
                    className: "border rounded-lg p-4 bg-muted/30 flex flex-col items-center justify-center min-h-[150px]",
                    children: form.image_url
                      ? jsxRuntime.jsxs("div", {
                          className: "relative w-full h-full",
                          children: [
                            jsxRuntime.jsx("img", { src: form.image_url, alt: "Preview", className: "w-full h-auto max-h-[220px] object-cover rounded shadow-sm" }),
                            jsxRuntime.jsx("p", { className: "text-xs text-muted-foreground mt-2 text-center break-all", children: form.image_url }),
                          ],
                        })
                      : jsxRuntime.jsxs("div", { className: "text-center text-muted-foreground", children: [jsxRuntime.jsx(ImageIcon, { className: "h-10 w-10 mx-auto opacity-20" }), jsxRuntime.jsx("p", { className: "text-sm", children: "Nenhuma imagem selecionada" })] }),
                  }),
                ],
              }),
              jsxRuntime.jsxs(Button, { onClick: () => void createBanner(), className: "w-full md:w-auto h-12 md:h-10 font-bold", children: [jsxRuntime.jsx(PlusIcon, { className: "h-4 w-4 mr-2" }), "Adicionar Banner"] }),
            ],
          }),
        ],
      }),
      jsxRuntime.jsxs("div", {
        className: "space-y-4",
        children: [
          jsxRuntime.jsx("h2", { className: "text-lg font-semibold", children: "Banners Existentes" }),
          items.length === 0 && jsxRuntime.jsx("p", { className: "text-muted-foreground text-center py-10 border rounded-lg bg-card", children: "Nenhum banner cadastrado." }),
          items.map((item) =>
            jsxRuntime.jsx(
              Card,
              {
                children: jsxRuntime.jsxs(CardContent, {
                  className: "pt-6",
                  children: [
                    jsxRuntime.jsxs("div", {
                      className: "flex flex-col lg:flex-row gap-6",
                      children: [
                        jsxRuntime.jsx("div", {
                          className: "w-full lg:w-1/3",
                          children: jsxRuntime.jsx("img", { src: item.image_url || "", alt: item.title || "Banner", className: "w-full h-32 object-cover rounded-lg border shadow-sm" }),
                        }),
                        jsxRuntime.jsxs("div", {
                          className: "flex-1 space-y-3",
                          children: [
                            jsxRuntime.jsxs("div", {
                              className: "grid grid-cols-1 md:grid-cols-2 gap-3",
                              children: [
                                jsxRuntime.jsxs("div", { className: "space-y-1", children: [jsxRuntime.jsx(Label, { className: "text-xs", children: "Título" }), jsxRuntime.jsx(Input, { value: item.title || "", onChange: (e) => void updateField(item.id, "title", e.target.value) })] }),
                                jsxRuntime.jsxs("div", { className: "space-y-1", children: [jsxRuntime.jsx(Label, { className: "text-xs", children: "Subtítulo" }), jsxRuntime.jsx(Input, { value: item.subtitle || "", onChange: (e) => void updateField(item.id, "subtitle", e.target.value) })] }),
                              ],
                            }),
                            jsxRuntime.jsxs("div", {
                              className: "space-y-2",
                              children: [
                                jsxRuntime.jsx(Label, { className: "text-xs", children: "URL da Imagem" }),
                                jsxRuntime.jsx(Input, { value: item.image_url || "", onChange: (e) => void updateField(item.id, "image_url", e.target.value) }),
                                jsxRuntime.jsxs("div", {
                                  className: "flex items-center gap-2",
                                  children: [
                                    jsxRuntime.jsx("input", {
                                      ref: (el) => {
                                        rowFileRef.current[item.id] = el;
                                      },
                                      type: "file",
                                      accept: ".jpg,.jpeg,.png,.webp,.gif,image/jpeg,image/png,image/webp,image/gif",
                                      className: "hidden",
                                      onChange: (e) => void handleRowUpload(item.id, e),
                                    }),
                                    jsxRuntime.jsx(Button, {
                                      type: "button",
                                      variant: "outline",
                                      size: "sm",
                                      onClick: () => rowFileRef.current[item.id]?.click(),
                                      disabled: rowUploadingId === item.id,
                                      children: rowUploadingId === item.id ? "Enviando..." : "Trocar imagem (upload)",
                                    }),
                                  ],
                                }),
                              ],
                            }),
                            jsxRuntime.jsxs("div", {
                              className: "flex flex-col sm:flex-row items-start sm:items-center justify-between pt-2 gap-4",
                              children: [
                                jsxRuntime.jsxs("div", {
                                  className: "flex flex-wrap items-center gap-4 w-full sm:w-auto",
                                  children: [
                                    jsxRuntime.jsxs("div", { className: "flex items-center gap-2", children: [jsxRuntime.jsx(Switch, { checked: normalizeBool(item.is_active), onCheckedChange: (v) => void updateField(item.id, "is_active", v) }), jsxRuntime.jsx(Label, { className: "text-sm font-medium", children: "Ativo" })] }),
                                    jsxRuntime.jsxs("div", { className: "flex items-center gap-2", children: [jsxRuntime.jsx(Label, { className: "text-xs font-bold text-muted-foreground uppercase", children: "Ordem:" }), jsxRuntime.jsx(Input, { type: "number", className: "w-16 h-9", value: Number(item.sort_order) || 0, onChange: (e) => void updateField(item.id, "sort_order", Number(e.target.value) || 0) })] }),
                                  ],
                                }),
                                jsxRuntime.jsxs(Button, { variant: "destructive", size: "sm", onClick: () => void removeBanner(item.id), className: "w-full sm:w-auto h-10 sm:h-9", children: [jsxRuntime.jsx(TrashIcon, { className: "h-4 w-4 mr-2" }), "Remover"] }),
                              ],
                            }),
                          ],
                        }),
                      ],
                    }),
                  ],
                }),
              },
              item.id
            )
          ),
        ],
      }),
    ],
  });
};

export { AdminBanners as default };
