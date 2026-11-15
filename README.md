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
| Convertire documenti (con OCR automatico) | Premi **Scegli file** oppure **trascina file e cartelle direttamente nella finestra**: PDF, Word (`.docx`), PowerPoint (`.pptx`), Excel (`.xlsx`), EPUB o ZIP vengono convertiti con estrazione automatica del testo nativo e del testo nelle immagini tramite PaddleOCR locale. |
| Unire tutti i file in un unico Markdown | Spunta **Unisci tutti i file in un unico file Markdown (.md)** nelle impostazioni (puoi anche scegliere il nome, di default `Documenti_uniti.md`): tutti i file convertiti vengono raccolti in un solo documento `.md` con indice iniziale. |
| Ispezionare o copiare l'anteprima | Clicca su qualsiasi riga completata nella **Coda** per visualizzarne il Markdown nel pannello **Anteprima** (doppio clic per aprire direttamente il file `.md`), oppure premi **Copia** per copiarlo subito negli appunti. |
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
