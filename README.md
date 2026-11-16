🌐 **Lingua / Language:** [🇮🇹 Italiano](#italiano) · [🇬🇧 English](#english)

---

<a id="italiano"></a>

# MarkItDown Desktop 1.5.0

**MarkItDown Desktop** è una GUI Windows per trasformare file, documenti con immagini o pagine scansionate, pagine web, sottotitoli YouTube e immagini in file Markdown. Usa il motore open source [MarkItDown di Microsoft][1] come base per i documenti e integra in automatico l'OCR offline multilingua tramite **PaddleOCR (PP-OCRv6)** con modelli ONNX locali inclusi nell'app.[3]

> Questa è una GUI indipendente basata su MarkItDown; non è un prodotto Microsoft ufficiale e non implica affiliazione con Microsoft.

| Elemento | Comportamento |
|---|---|
| Documenti e PDF | Converte i principali formati supportati da MarkItDown in Markdown UTF-8 ed esegue **automaticamente di default l'OCR** sulle pagine PDF scansionate/immagini e sulle immagini incorporate nei documenti. |
| Office e Archivi | Per `.docx`, `.pptx`, `.xlsx`, `.epub` e `.zip`, oltre al testo nativo analizza automaticamente le immagini incorporate ed estrae eventuale testo leggibile in una sezione dedicata (`## Testo OCR da immagini incorporate`). |
| Link web | Scarica soltanto l’URL incollato dall’utente, rimuove menu, banner cookie, pubblicità e altri elementi non utili, quindi salva il testo principale in Markdown. |
| YouTube | Recupera titolo e sottotitoli pubblici, generando righe nel formato `[MM:SS] Testo`. |
| OCR immagini | Legge localmente PNG, JPG, JPEG, WEBP, BMP, TIF e TIFF con **PaddleOCR (PP-OCRv6)** multilingua incluso nell’app (`_internal\ocr\ppocrv6`); non usa LLM né API esterne né download da Internet. |
| EXIF | Riporta formato, risoluzione, modalità colore, DPI e, quando presenti, data e dati della fotocamera. |
| Output | Scrive un file `.md` UTF-8 per ciascun elemento (modalità 1:1) oppure **unisce tutti i file della coda in un unico file `.md`** con indice automatico se si attiva l'opzione *Unisci tutti i file in un unico file Markdown (.md)*. |

## Installazione Windows

Esegui `MarkItDown-Desktop-Setup-1.5.0.exe`. Il setup installa l’app, la cartella `_internal` con tutte le librerie, FFmpeg, `pypdfium2`, `onnxruntime`, `OpenCV` e i modelli locali **PaddleOCR PP-OCRv6** (`det.onnx`, `rec.onnx`, `rec_dict.json` con dizionario multilingua unificato da 18.708 caratteri). **Non è necessario installare Python, PaddleOCR o altre dipendenze né avere connessione Internet per l'OCR.**

Nel passaggio **Componenti** puoi attivare anche la voce facoltativa del menu contestuale Windows. L’installazione è per l’utente corrente e non richiede privilegi amministrativi.

## Uso ordinario

Apri **MarkItDown Desktop**, scegli una cartella di destinazione, aggiungi uno o più elementi e premi **Converti i file ↗**. L’OCR parte sempre in automatico quando carichi immagini, PDF scansionati o documenti con immagini al loro interno, senza dover attivare opzioni manuali. La coda continua a elaborare gli altri elementi anche se uno produce un errore. L’anteprima visualizza l’ultimo Markdown riuscito; se esiste già un file con lo stesso nome, l’app crea automaticamente `nome (2).md`, senza sovrascrivere il risultato precedente.

| Azione | Come procedere |
|---|---|
| Cambiare modalità (**Classica** ↔ **Chatbot**) | Premi **⚙ Impostazioni** (oppure il pulsante rapido **💬 Modalità Chatbot** / **📋 Modalità Classica** in alto a destra): puoi passare istantaneamente dalla **Modalità Classica** (tema chiaro editoriale con Coda e Anteprima) alla **Modalità Chatbot** (tema scuro `#131314` / `#1E1F20` stile Assistente Standalone con sidebar delle chat, card `.md` espandibili in conversazione e barra di invio inferiore). La scelta viene salvata in automatico. |
| Convertire documenti (con OCR automatico) | Premi **Scegli file** (o **＋ Carica file** in modalità Chatbot) oppure **trascina file e cartelle direttamente nella finestra**: PDF, Word (`.docx`), PowerPoint (`.pptx`), Excel (`.xlsx`), EPUB o ZIP vengono convertiti con estrazione automatica del testo nativo e del testo nelle immagini tramite PaddleOCR locale. |
| Unire tutti i file in un unico Markdown | Spunta **Unisci tutti i file in un unico file Markdown (.md)** nelle impostazioni (oppure premi **🔗 Unisci tutti i file in un unico Markdown (.md)** direttamente sotto le card nella modalità Chatbot): tutti i file convertiti vengono raccolti in un solo documento `.md` con indice iniziale. |
| Ispezionare o copiare l'anteprima | In modalità Classica clicca su qualsiasi riga completata nella **Coda** per visualizzarne il Markdown nel pannello **Anteprima**; in modalità Chatbot premi **👁 Anteprima** o **📋 Copia** direttamente sulla card del file `.md` generato. |
| Usare la versione Web Portabile | Apri `Portable MarkItDown.html` in qualsiasi browser moderno (anche da `file://` e senza connessione Internet): include in un unico file HTML monolitico (~60 MB) PDF.js, ONNX Runtime Web e PaddleOCR con OCR automatico su PDF, immagini e Office (`.docx`, `.pptx`, `.xlsx`, `.epub`). |
| Convertire un articolo | Premi **Link web / YouTube**, incolla l’URL di una pagina e premi **Aggiungi link**. |
| Trascrivere un video YouTube | Incolla un URL `youtube.com`, `youtu.be`, `shorts` o `embed`; la lingua selezionata nell’app viene richiesta per prima, con inglese come fallback. |
| Estrarre testo da un’immagine | Aggiungi PNG, JPG, JPEG, WEBP, BMP o TIFF come un normale file; il risultato contiene una tabella EXIF e la sezione **Testo OCR (PaddleOCR PP-OCRv6 offline)**. |

## OCR automatico con PaddleOCR PP-OCRv6 (100% locale e offline)

L’OCR utilizza i modelli neurali ufficiali **PaddleOCR PP-OCRv6** (`PP-OCRv6_small_det` per il rilevamento poligonale del testo e `PP-OCRv6_small_rec` per il riconoscimento multilingua) eseguiti localmente tramite **ONNX Runtime** in `_internal\ocr\ppocrv6`:
- **Supporto multilingua unificato**: Italiano (`it`), Inglese (`en`), Francese (`fr`), Tedesco (`de`), Spagnolo (`es`), Portoghese (`pt`), tutte le lingue latine, Cinese (`ch`) e Giapponese (`japan`) in un unico modello locale senza download runtime.
- **Rettifica prospettica e ricostruzione layout**: ogni box di testo viene raddrizzato tramite trasformazione prospettica (`warpPerspective`) e ricomposto in righe e paragrafi Markdown ordinati geometricamente.

### Come funziona sui documenti:
1. **PDF scansionati o misti**: ogni pagina viene analizzata con `pypdfium2`. Se una pagina contiene meno di 25 caratteri di testo nativo, l’app renderizza la pagina ad alta definizione (2×) ed esegue l’OCR automatico con PaddleOCR, contrassegnando la sezione con `## Pagina X *(OCR)*`. Se una pagina è puramente fotografica/illustrativa e non contiene testo leggibile, viene ignorata automaticamente.
2. **PDF digitali con immagini incorporate**: oltre al testo nativo della pagina, l’app ispeziona gli oggetti immagine incorporati e, se rileva testo aggiuntivo non duplicato, lo aggiunge in `### Testo OCR da immagini (Pagina X)`.
3. **Documenti Office (`.docx`, `.pptx`, `.xlsx`) ed EPUB/ZIP**: dopo la conversione standard, l’app ispeziona i file multimediali incorporati nel pacchetto (associando anche il numero di slide per i file `.pptx`) e appende la sezione `## Testo OCR da immagini incorporate` quando rileva testo leggibile.
4. **Immagini singole**: produce una scheda con tabella `## Metadati immagine` (EXIF) e `## Testo OCR (PaddleOCR PP-OCRv6 offline)`.

## Link web e YouTube

Il dialogo **Link web / YouTube** è una finestra modale: incolli un solo URL alla volta, lo aggiungi alla coda e lo converti insieme agli altri elementi. Per le pagine web l’app seleziona `article`, `main` o il contenuto principale, eliminando script, barre di navigazione, footer, banner cookie e classi comuni di pubblicità. Il risultato conserva il titolo, la fonte e le sezioni testuali utili.

Per YouTube, l’app usa `youtube-transcript-api` con la sintassi recente `YouTubeTranscriptApi().fetch(...)` e un fallback controllato al precedente `get_transcript`. Il video deve avere sottotitoli pubblici accessibili.[2]

> Le conversioni di URL e YouTube richiedono Internet perché recuperano il contenuto che l’utente ha esplicitamente incollato. Non inviano file locali, immagini o contenuti a un’AI.

## Audio, video e privacy

L’app può convertire WAV, MP3, M4A, AAC, AIFF, FLAC, OGG, OPUS, MP4, WEBM, MOV, MKV e AVI. FFmpeg normalizza localmente l’audio; per i video viene estratta soltanto la traccia sonora. Il selettore **Lingua OCR / Audio** imposta la lingua prioritaria per l’OCR e per la trascrizione vocale.

| Funzione | Dati locali | Rete necessaria |
|---|---|---|
| Documenti, PDF e Office (con PaddleOCR automatico) | Sì (modelli ONNX locali in `_internal\ocr\ppocrv6`) | No |
| OCR immagine ed EXIF | Sì (modelli ONNX locali in `_internal\ocr\ppocrv6`) | No |
| Conversione di una pagina URL | No, scarica solo la pagina richiesta | Sì |
| Sottotitoli YouTube | No, recupera solo titolo e sottotitoli pubblici | Sì |
| Trascrizione audio/video | Audio normalizzato localmente | Sì, perché usa `SpeechRecognition` con il servizio Google |

## Menu contestuale Windows

La consegna include `Install_Context_Menu.ps1` e `Remove_Context_Menu.ps1`. Per aggiungere la voce **Converti in Markdown con MarkItDown Desktop** nel menu contestuale dell’utente corrente, esegui in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\Install_Context_Menu.ps1
```

Lo script non installa software aggiuntivo; registra solo la voce di menu per aprire i file selezionati nella coda dell’app.

## Limiti noti

MarkItDown è progettato per estrarre contenuto e struttura utile, non per riprodurre l’aspetto visivo originale di un documento.[1] Le pagine web con paywall, contenuto esclusivamente JavaScript o anti-bot potrebbero non essere convertibili. I video YouTube senza sottotitoli pubblici o soggetti a limiti di rete non producono trascrizioni. L’OCR locale non interpreta grafici o layout complessi come un modello visivo generativo: riconosce il testo stampato nell’immagine.

## Riferimenti

[1]: https://github.com/microsoft/markitdown "Repository ufficiale Microsoft di MarkItDown"
[2]: https://pypi.org/project/youtube-transcript-api/ "youtube-transcript-api su PyPI"
[3]: https://github.com/PaddlePaddle/PaddleOCR "Repository ufficiale PaddleOCR (PP-OCRv6)"

---

<a id="english"></a>

# MarkItDown Desktop 1.5.0

**MarkItDown Desktop** is a Windows GUI for converting files, documents with images or scanned pages, web pages, YouTube subtitles, and images into Markdown files. It uses Microsoft's open-source [MarkItDown][1] engine as the base for documents and automatically integrates offline multilingual OCR via **PaddleOCR (PP-OCRv6)** with local ONNX models bundled in the app.[3]

> This is an independent GUI based on MarkItDown; it is not an official Microsoft product and implies no affiliation with Microsoft.

| Item | Behavior |
|---|---|
| Documents and PDFs | Converts the main formats supported by MarkItDown into UTF-8 Markdown and **automatically runs OCR by default** on scanned PDF pages/images and on images embedded within documents. |
| Office and Archives | For `.docx`, `.pptx`, `.xlsx`, `.epub`, and `.zip`, in addition to native text, it automatically analyzes embedded images and extracts any readable text into a dedicated section (`## Testo OCR da immagini incorporate`). |
| Web Links | Downloads only the URL pasted by the user, removes menus, cookie banners, advertisements, and other non-essential elements, and then saves the main text in Markdown. |
| YouTube | Fetches the title and public subtitles, generating lines in the format `[MM:SS] Text`. |
| Image OCR | Reads PNG, JPG, JPEG, WEBP, BMP, TIF, and TIFF locally with multilingual **PaddleOCR (PP-OCRv6)** bundled in the app (`_internal\ocr\ppocrv6`); does not use LLMs, external APIs, or internet downloads. |
| EXIF | Reports format, resolution, color mode, DPI, and, when present, date and camera data. |
| Output | Writes a UTF-8 `.md` file for each item (1:1 mode) or **merges all files in the queue into a single `.md` file** with an automatic table of contents if the option *Merge all files into a single Markdown file (.md)* is enabled. |

## Windows Installation

Run `MarkItDown-Desktop-Setup-1.5.0.exe`. The installer sets up the app, the `_internal` folder with all libraries, FFmpeg, `pypdfium2`, `onnxruntime`, `OpenCV`, and local **PaddleOCR PP-OCRv6** models (`det.onnx`, `rec.onnx`, `rec_dict.json` with a unified multilingual dictionary of 18,708 characters). **No installation of Python, PaddleOCR, or other dependencies is required, nor is an Internet connection needed for OCR.**

In the **Components** step, you can also enable the optional Windows context menu entry. Installation is for the current user and does not require administrator privileges.

## Everyday Usage

Open **MarkItDown Desktop**, choose a destination folder, add one or more items, and click **Convert Files ↗**. OCR always starts automatically when loading images, scanned PDFs, or documents with images inside, without having to enable manual options. The queue continues processing remaining items even if one produces an error. The preview displays the last successfully converted Markdown; if a file with the same name already exists, the app automatically creates `name (2).md`, without overwriting the previous result.

| Action | How to proceed |
|---|---|
| Switch mode (**Classic** ↔ **Chatbot**) | Click **⚙ Settings** (or the quick button **💬 Chatbot Mode** / **📋 Classic Mode** in the top right): you can switch instantly from **Classic Mode** (editorial light theme with Queue and Preview) to **Chatbot Mode** (dark theme `#131314` / `#1E1F20` standalone assistant style with chat sidebar, expandable `.md` cards in conversation, and bottom input bar). The choice is saved automatically. |
| Convert documents (with automatic OCR) | Click **Choose Files** (or **＋ Upload Files** in Chatbot mode) or **drag and drop files and folders directly into the window**: PDF, Word (`.docx`), PowerPoint (`.pptx`), Excel (`.xlsx`), EPUB, or ZIP are converted with automatic extraction of native text and image text via local PaddleOCR. |
| Merge all files into a single Markdown file | Check **Merge all files into a single Markdown file (.md)** in settings (or click **🔗 Merge all files into a single Markdown (.md)** directly below cards in Chatbot mode): all converted files are collected into a single `.md` document with an initial table of contents. |
| Inspect or copy preview | In Classic mode, click on any completed row in the **Queue** to view its Markdown in the **Preview** panel; in Chatbot mode, click **👁 Preview** or **📋 Copy** directly on the generated `.md` file card. |
| Use Portable Web Version | Open `Portable MarkItDown.html` in any modern browser (even via `file://` and without an Internet connection): it includes PDF.js, ONNX Runtime Web, and PaddleOCR in a single monolithic HTML file (~60 MB) with automatic OCR on PDFs, images, and Office (`.docx`, `.pptx`, `.xlsx`, `.epub`). |
| Convert an article | Click **Web Link / YouTube**, paste a page URL, and click **Add Link**. |
| Transcribe a YouTube video | Paste a `youtube.com`, `youtu.be`, `shorts`, or `embed` URL; the language selected in the app is queried first, with English as fallback. |
| Extract text from an image | Add PNG, JPG, JPEG, WEBP, BMP, or TIFF like a normal file; the result contains an EXIF table and the **OCR Text (PaddleOCR PP-OCRv6 offline)** section. |

## Automatic OCR with PaddleOCR PP-OCRv6 (100% Local and Offline)

OCR utilizes the official **PaddleOCR PP-OCRv6** neural models (`PP-OCRv6_small_det` for polygon text detection and `PP-OCRv6_small_rec` for multilingual recognition) executed locally via **ONNX Runtime** in `_internal\ocr\ppocrv6`:
- **Unified multilingual support**: Italian (`it`), English (`en`), French (`fr`), German (`de`), Spanish (`es`), Portuguese (`pt`), all Latin languages, Chinese (`ch`), and Japanese (`japan`) in a single local model without runtime downloads.
- **Perspective rectification and layout reconstruction**: each text box is straightened via perspective transformation (`warpPerspective`) and recomposed into geometrically ordered Markdown lines and paragraphs.

### How it works on documents:
1. **Scanned or mixed PDFs**: each page is analyzed with `pypdfium2`. If a page contains fewer than 25 characters of native text, the app renders the page in high definition (2×) and executes automatic OCR with PaddleOCR, tagging the section with `## Pagina X *(OCR)*`. If a page is purely photographic/illustrative and contains no readable text, it is automatically skipped.
2. **Digital PDFs with embedded images**: in addition to native page text, the app inspects embedded image objects and, if it detects non-duplicated additional text, adds it under `### Testo OCR da immagini (Pagina X)`.
3. **Office documents (`.docx`, `.pptx`, `.xlsx`) and EPUB/ZIP**: after standard conversion, the app inspects media files embedded in the package (also associating slide numbers for `.pptx` files) and appends the `## Testo OCR da immagini incorporate` section when readable text is detected.
4. **Single images**: produces a card with a `## Metadati immagine` (EXIF) table and `## Testo OCR (PaddleOCR PP-OCRv6 offline)`.

## Web Links and YouTube

The **Web Link / YouTube** dialog is a modal window: paste one URL at a time, add it to the queue, and convert it alongside other items. For web pages, the app selects `article`, `main`, or the main content, removing scripts, navigation bars, footers, cookie banners, and common advertisement classes. The result preserves the title, source, and useful text sections.

For YouTube, the app uses `youtube-transcript-api` with the recent `YouTubeTranscriptApi().fetch(...)` syntax and a controlled fallback to the earlier `get_transcript`. The video must have publicly accessible subtitles.[2]

> URL and YouTube conversions require an Internet connection because they retrieve content explicitly pasted by the user. They do not send local files, images, or content to an AI.

## Audio, Video, and Privacy

The app can convert WAV, MP3, M4A, AAC, AIFF, FLAC, OGG, OPUS, MP4, WEBM, MOV, MKV, and AVI. FFmpeg normalizes audio locally; for video, only the sound track is extracted. The **OCR / Audio Language** selector sets the priority language for OCR and speech transcription.

| Feature | Local Data | Network Required |
|---|---|---|
| Documents, PDFs, and Office (with automatic PaddleOCR) | Yes (local ONNX models in `_internal\ocr\ppocrv6`) | No |
| Image OCR and EXIF | Yes (local ONNX models in `_internal\ocr\ppocrv6`) | No |
| Web URL conversion | No, only downloads the requested page | Yes |
| YouTube subtitles | No, fetches only public title and subtitles | Yes |
| Audio/video transcription | Audio normalized locally | Yes, because it uses `SpeechRecognition` with Google service |

## Windows Context Menu

The delivery includes `Install_Context_Menu.ps1` and `Remove_Context_Menu.ps1`. To add the **Convert to Markdown with MarkItDown Desktop** option in the current user's context menu, run in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\Install_Context_Menu.ps1
```

The script does not install additional software; it only registers the menu entry to open selected files in the app queue.

## Known Limitations

MarkItDown is designed to extract useful content and structure, not to reproduce the original visual appearance of a document.[1] Web pages with paywalls, JavaScript-only content, or anti-bot protections may not be convertible. YouTube videos without public subtitles or subject to network restrictions do not produce transcripts. Local OCR does not interpret charts or complex layouts like a generative vision model: it recognizes printed text within the image.

## References

[1]: https://github.com/microsoft/markitdown "Official Microsoft MarkItDown Repository"
[2]: https://pypi.org/project/youtube-transcript-api/ "youtube-transcript-api on PyPI"
[3]: https://github.com/PaddlePaddle/PaddleOCR "Official PaddleOCR Repository (PP-OCRv6)"
