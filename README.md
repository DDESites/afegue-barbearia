# Afegue Barbearia — Site institucional

Site moderno e leve para a **Afegue Barbearia**: apresenta serviços, equipe,
localização e facilita o agendamento pelo WhatsApp.

Construído em HTML, CSS e JavaScript puros — sem dependências, sem build e com
carregamento rápido (a página inicial soma menos de 100 KB sem as fontes externas).

---

## Como executar

**Opção 1 — servidor local (recomendado)**

```powershell
powershell -ExecutionPolicy Bypass -File server.ps1
```

Depois acesse <http://localhost:8092> (a porta está definida no topo do `server.ps1`).

**Opção 2 — abrir direto**

Basta abrir o arquivo `index.html` no navegador. Funciona offline (as fontes do
Google Fonts caem automaticamente para Georgia/Arial se não houver internet).

---

## Estrutura

```
afegue-barbearia/
├── index.html          → Início: hero, destaques, serviços, apresentação,
│                          depoimentos, localização e chamada final
├── servicos.html       → Lista completa de serviços + como agendar
├── sobre.html          → A barbearia: história, equipe e proposta
├── contato.html        → Contato, horários, mapa e formulário → WhatsApp
├── css/style.css       → Todo o visual (design tokens no topo do arquivo)
├── js/main.js          → WhatsApp, menu mobile, animações e formulário
│                          ⚠️ CONFIGURAÇÃO RÁPIDA no topo do arquivo
├── js/depoimentos.js   → Textos dos depoimentos (fácil de trocar)
├── img/                → Emblema, favicon e ilustrações (SVG)
│   ├── emblema.svg        selo da marca (cabeçalho e rodapé)
│   ├── favicon.svg
│   ├── hero-cartaz.svg    cartaz da seção principal
│   ├── espaco.svg         ilustração do espaço
│   └── ferramentas.svg    ilustração das ferramentas
├── identidade.png/.svg → Identidade visual original da marca (fonte)
├── selo-avatar.png/.svg→ Selo/avatar original da marca (fonte)
├── server.ps1          → Servidor local para desenvolvimento
├── capturar-mobile.ps1 → Gera as capturas mobile (390 px) em `.capturas/`
├── .capturas/          → Prints de referência das 4 páginas (desktop e mobile)
└── docs/PRD.md         → Requisitos do projeto
```

> **Nota sobre as capturas:** no Windows o Chrome headless não deixa janelas com
> menos de 500 px de largura. Por isso o `capturar-mobile.ps1` monta a página
> dentro de um `<iframe>` de 390 px, tira o print e recorta — assim o mobile é
> renderizado de verdade. Para prints de desktop, use o Chrome direto:
>
> ```powershell
> & "C:\Program Files\Google\Chrome\Application\chrome.exe" --headless=new --disable-gpu --hide-scrollbars --window-size=1440,2600 --screenshot=".capturas\index-desktop.png" http://localhost:8092/index.html
> ```

---

## ⚠️ Checklist antes de publicar

Nada abaixo foi inventado como definitivo: tudo está marcado no site com o selo
**“a confirmar”** ou **“preço · a confirmar”**. Substitua pelos dados reais.

| # | Item | Onde alterar |
|---|------|--------------|
| 1 | **Número do WhatsApp** (55 + DDD + número) | topo de `js/main.js` → `WHATSAPP_NUMERO` |
| 2 | **Telefone** para ligação `(61) 99999-9999` | todos os `index/... .html` → links `tel:` e texto do rodapé/contato |
| 3 | **Endereço completo** (rua, número, bairro, cidade) | `contato.html` (cartão Endereço) e `index.html` (seção Onde estamos) |
| 4 | **Coordenadas do mapa** | `contato.html` → `<iframe>` e botões Google Maps/Waze |
| 5 | **Horários de funcionamento** | tabelas em `index.html` e `contato.html` |
| 6 | **Preços e durações dos serviços** | cartões em `servicos.html` e `index.html` (chips `Preço · a confirmar`) |
| 7 | **Instagram real** | links `instagram.com/afeguebarbearia` em todas as páginas |
| 8 | **Nomes, fotos e funções da equipe** | `sobre.html` → seção Equipe |
| 9 | **Depoimentos autorizados** | `js/depoimentos.js` (hoje há 3 textos de exemplo) |
| 10 | **Fotos reais** da barbearia, equipe e cortes | substituir `img/hero-cartaz.svg`, `img/espaco.svg` e `img/ferramentas.svg` por JPG/WebP otimizados |
| 11 | **Imagem de compartilhamento (og:image)** | adicionar a tag em todas as páginas (PNG 1200×630) |

### Como trocar uma ilustração por uma foto

Substitua a tag `<img>` mantendo as proporções e os atributos:

```html
<div class="moldura-ouro revelar">
  <img src="img/espaco.jpg" alt="Descrição da foto" width="960" height="640" loading="lazy">
  <span class="moldura-ouro__etiqueta">Nosso espaço</span>
</div>
```

Dica: converta as fotos para **WebP** e redimensione para no máximo 1600 px de
largura — o site continua rápido e o visual não muda.

---

## Identidade visual

A interface segue a identidade da fachada:

| Papel | Cor |
|-------|-----|
| Base | preto `#08090c` e grafite `#0d0f13` / `#14171d` |
| Texto | branco `#f4f5f7` e prata `#c3c8d0` |
| Ações e destaques | vermelho vivo `#d81f2a` |
| Ornamentos, títulos de apoio e linhas | dourado `#e6bd6a` / `#c08f2f` |

- **Títulos:** Playfair Display (serifada de personalidade)
- **Textos e controles:** Inter (sem serifa, alta legibilidade)

Tudo está centralizado em `css/style.css` (bloco `:root`) — mudando as variáveis
ali, o site inteiro acompanha.

Elementos de marca usados com moderação: emblema circular (AB + navalhas
cruzadas), coroa, listras do poste de barbeiro e detalhes em losango vermelho.

---

## Funcionalidades

- **Botão flutuante de WhatsApp** em todas as páginas (fixo no canto).
- **Todos os botões de agendamento** abrem o WhatsApp com mensagem pronta
  (atributo `data-zap` em cada botão — edite o texto direto no HTML).
- **Menu mobile** com botão hambúrguer, fecha com `Esc` ou ao tocar num link.
- **Formulário de contato** que gera a mensagem e só envia após a confirmação
  do visitante (nenhum dado sai automaticamente).
- **Mapa** OpenStreetMap + atalhos para Google Maps e Waze.
- **Links clicáveis** para telefone, Instagram e endereço.
- **Animações discretas** de entrada, desligadas automaticamente para quem
  usa a preferência “reduzir movimento” no sistema.
- **Acessibilidade:** link “pular para o conteúdo”, navegação por teclado,
  foco visível dourado, contraste alto, `alt` em todas as imagens e
  `aria-current` na página ativa.
- **Impressão:** estilos de impressão já preparados (cabeçalho e botões saem).

---

## Desempenho

- HTML, CSS e JS minúsculos e sem dependências externas além das fontes.
- Imagens em **SVG** (vetoriais, pesam poucos KB e escalam em qualquer tela).
- `loading="lazy"` nas imagens abaixo da dobra.
- Testado sem estouro horizontal de 360 px (celular) até desktop.

---

## Evoluções possíveis (previstas no PRD)

- Agendamento integrado com escolha de serviço, profissional e horário.
- Área administrativa para atualizar serviços, preços e horários.
- Galeria de trabalhos com filtros.
- Programa de fidelidade ou ofertas especiais.
