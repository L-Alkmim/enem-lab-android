# ENEM Lab Android 2.0

Aplicativo Android nativo (Activity Java + `WebView` local e leitor de PDFs por `PdfRenderer`) construído a partir do HTML enviado. **Não é um site aberto no Edge.**

## Build

Abra a pasta do projeto no **Android Studio**, instale Android SDK Platform 35 e JDK 17, sincronize o Gradle (wrapper incluído, com download automático do Gradle 8.9) e selecione **Build > Build APK(s)**. Saída: `app/build/outputs/apk/debug/app-debug.apk`. No Windows também é possível executar `GERAR_APK_WINDOWS.bat` quando SDK e JDK estiverem configurados. Para gerar em GitHub Actions, publique este diretório num repositório e execute a ação **ENEM Lab — Android APK**; o fluxo produz um artefato instalável de depuração.

## Funcionalidades

- 8 provas oficiais do ENEM, 1º e 2º dias, 2022–2025, com gabaritos e progressos locais.
- Cartão-resposta interativo, filtros, idioma estrangeiro, questões para revisão, cronômetro, resultados e redação.
- Leitor PDF Android próprio, zoom e navegação página a página; download do INEP em armazenamento privado para leitura posterior offline e importação de PDF local.
- Exportação/restauração do backup do usuário com seletor nativo de arquivos.
- TRI 3PL/EAP usando parâmetros reais dos arquivos `DADOS/ITENS_PROVA_AAAA.csv` publicados pelo INEP. A aba TRI permite importar cada ano. Há um espelho público opcional para os dados de 2025; a importação manual funciona para qualquer ano contemplado.

### Metodologia e limite da TRI

A fórmula de probabilidade correta de cada item é `P(θ) = c + (1 − c) / (1 + exp(−1.7·a·(θ−b)))`. A estimativa `θ` é a esperança a posteriori calculada numericamente com priori Normal(0,1). A escala `500 + 100θ` fornece **nota estimada indicativa**. O código não inventa valores de dificuldade, discriminação ou chute. Sem o dataset real e as respostas completas, a área mostra **base TRI necessária** ou **área incompleta**, nunca uma pontuação fictícia. O software não reproduz integralmente os procedimentos do INEP, nem afirma equivalência à pontuação publicada.

Importação: baixe o ZIP de microdados do INEP para 2022–2025, extraia **somente** o `ITENS_PROVA_AAAA.csv` e importe pela aba TRI. O mapeamento usa `SG_AREA`, `TX_COR`, `CO_PROVA`, `TP_LINGUA`, `CO_POSICAO`, `TX_GABARITO`, `NU_PARAM_A/B/C` e indicador de item abandonado. Exige correspondência mínima de 90% entre o gabarito da prova e o CSV para não misturar cadernos. Uma área com parâmetros incompletos não gera nota. O botão opcional **Baixar base 2025** lê um espelho da base oficial hospedado publicamente no GitHub; os dados são interpretados localmente.

Fontes: [Microdados do ENEM — INEP](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem) e [Como a nota é calculada — Agência Gov](https://agenciagov.ebc.com.br/noticias/202410/enem-2024-entenda-como-a-nota-do-exame-e-calculada).

## Testes

Execute `node tests/tri.test.js` para testar EAP/3PL e importação de parâmetros sintéticos. O HTML foi exercitado no Chromium headless em tela móvel com biblioteca, aba TRI, simulado, correção e modal de resultados. O APK **não foi compilado nem testado em dispositivo** neste ambiente, que não contém o SDK Android. O código-fonte foi preparado para compilação, mas requer validação em aparelho/emulador real antes da distribuição.

Este é um projeto independente sem vínculo oficial com o INEP.
