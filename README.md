# MarkItDown Desktop 1.5.0

**MarkItDown Desktop** è una GUI Windows per trasformare file, documenti con immagini o pagine scansionate, pagine web, sottotitoli YouTube e immagini in file Markdown. Usa il motore open source [MarkItDown di Microsoft][1] come base per i documenti e integra in automatico l'OCR offline multilingua tramite Tesseract 5 incluso nell'app.

> Questa è una GUI indipendente basata su MarkItDown; non è un prodotto Microsoft ufficiale e non implica affiliazione con Microsoft.

| Elemento | Comportamento |
|---|---|
| Documenti e PDF | Converte i principali formati supportati da MarkItDown in Markdown UTF-8 ed esegue **automaticamente di default l'OCR** sulle pagine PDF scansionate/immagini e sulle immagini incorporate nei documenti. |
| Office e Archivi | Per `.docx`, `.pptx`, `.xlsx`, `.epub` e `.zip`, oltre al testo nativo analizza automaticamente le immagini incorporate ed estrae eventuale testo leggibile in una sezione dedicata (`## Testo OCR da immagini incorporate`). |
| Link web | Scarica soltanto l’URL incollato dall’utente, rimuove menu, banner cookie, pubblicità e altri elementi non utili, quindi salva il testo principale in Markdown. |
| YouTube | Recupera titolo e sottotitoli pubblici, generando righe nel formato `[MM:SS] Testo`. |
| OCR immagini | Legge localmente PNG, JPG, JPEG, WEBP, BMP, TIF e TIFF con Tesseract 5 multilingua incluso nell’app; non usa LLM né API esterne. |
| EXIF | Riporta formato, risoluzione, modalità colore, DPI e, quando presenti, data e dati della fotocamera. |
| Output | Scrive un file `.md` UTF-8 per ciascun elemento nella cartella scelta. |

## Installazione Windows

Esegui `MarkItDown-Desktop-Setup-1.5.0.exe`. Il setup installa l’app, la cartella `_internal` con tutte le librerie, FFmpeg, `pypdfium2` e il motore OCR locale con i modelli multilingua (`ita`, `eng`, `fra`, `deu`, `spa`, `por`, `chi_sim`, `jpn` e `osd`). **Non è necessario installare Python, Tesseract o altre dipendenze.**

Nel passaggio **Componenti** puoi attivare anche la voce facoltativa del menu contestuale Windows. L’installazione è per l’utente corrente e non richiede privilegi amministrativi.

## Uso ordinario

Apri **MarkItDown Desktop**, scegli una cartella di destinazione, aggiungi uno o più elementi e premi **Converti i file ↗**. L’OCR parte sempre in automatico quando carichi immagini, PDF scansionati o documenti con immagini al loro interno, senza dover attivare opzioni manuali. La coda continua a elaborare gli altri elementi anche se uno produce un errore. L’anteprima visualizza l’ultimo Markdown riuscito; se esiste già un file con lo stesso nome, l’app crea automaticamente `nome (2).md`, senza sovrascrivere il risultato precedente.

| Azione | Come procedere |
|---|---|
| Convertire documenti (con OCR automatico) | Premi **Scegli file** e aggiungi PDF, Word (`.docx`), PowerPoint (`.pptx`), Excel (`.xlsx`), EPUB o ZIP: il testo nativo e il testo nelle immagini vengono estratti automaticamente. |
| Convertire un articolo | Premi **Link web / YouTube**, incolla l’URL di una pagina e premi **Aggiungi link**. |
| Trascrivere un video YouTube | Incolla un URL `youtube.com`, `youtu.be`, `shorts` o `embed`; la lingua selezionata nell’app viene richiesta per prima, con inglese come fallback. |
| Estrarre testo da un’immagine | Aggiungi PNG, JPG, JPEG, WEBP, BMP o TIFF come un normale file; il risultato contiene una tabella EXIF e la sezione **Testo OCR (offline)**. |

## OCR automatico su PDF, Office e immagini (100% offline)

L’OCR usa **Tesseract 5** incluso in `_internal\ocr` e i modelli linguistici locali multilingua:
- **Italiano** (`ita`), **Inglese** (`eng`), **Francese** (`fra`), **Tedesco** (`deu`), **Spagnolo** (`spa`), **Portoghese** (`por`), **Cinese semplificato** (`chi_sim`), **Giapponese** (`jpn`) e rilevamento orientamento/script (`osd`).

### Come funziona sui documenti:
1. **PDF scansionati o misti**: ogni pagina viene analizzata con `pypdfium2`. Se una pagina contiene meno di 25 caratteri di testo nativo, l’app estrae le immagini della pagina (o renderizza la pagina ad alta definizione) ed esegue l’OCR automatico, contrassegnando la sezione con `## Pagina X *(OCR)*`. Se una pagina è puramente fotografica/illustrativa e non contiene testo leggibile, il rumore visivo viene scartato automaticamente.
2. **PDF digitali con immagini incorporate**: oltre al testo nativo della pagina, l’app ispeziona gli oggetti immagine incorporati e, se rileva testo aggiuntivo non duplicato, lo aggiunge in `### Testo OCR da immagini (Pagina X)`.
3. **Documenti Office (`.docx`, `.pptx`, `.xlsx`) ed EPUB/ZIP**: dopo la conversione standard, l’app ispeziona i file multimediali incorporati nel pacchetto (associando anche il numero di slide per i file `.pptx`) e appende la sezione `## Testo OCR da immagini incorporate` quando rileva testo leggibile.
4. **Immagini singole**: produce una scheda con tabella `## Metadati immagine` (EXIF) e `## Testo OCR (offline)`.

Prima della lettura l'app applica localmente scala di grigi, ridimensionamento adattivo, autocontrasto e miglioramento del contrasto, con filtro anti-rumore sulle righe spurie.[3] [4]

## Link web e YouTube

Il dialogo **Link web / YouTube** è una finestra modale: incolli un solo URL alla volta, lo aggiungi alla coda e lo converti insieme agli altri elementi. Per le pagine web l’app seleziona `article`, `main` o il contenuto principale, eliminando script, barre di navigazione, footer, banner cookie e classi comuni di pubblicità. Il risultato conserva il titolo, la fonte e le sezioni testuali utili.

Per YouTube, l’app usa `youtube-transcript-api` con la sintassi recente `YouTubeTranscriptApi().fetch(...)` e un fallback controllato al precedente `get_transcript`. Il video deve avere sottotitoli pubblici accessibili.[2]

> Le conversioni di URL e YouTube richiedono Internet perché recuperano il contenuto che l’utente ha esplicitamente incollato. Non inviano file locali, immagini o contenuti a un’AI.

## Audio, video e privacy

L’app può convertire WAV, MP3, M4A, AAC, AIFF, FLAC, OGG, OPUS, MP4, WEBM, MOV, MKV e AVI. FFmpeg normalizza localmente l’audio; per i video viene estratta soltanto la traccia sonora. Il selettore **Lingua OCR / Audio** imposta la lingua prioritaria per l’OCR e per la trascrizione vocale.

| Funzione | Dati locali | Rete necessaria |
|---|---|---|
| Documenti, PDF e Office (con OCR automatico) | Sì | No |
| OCR immagine ed EXIF | Sì | No |
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
[3]: https://github.com/tesseract-ocr/tessdoc/blob/main/Installation.md "Installazione ufficiale Tesseract"
[4]: https://github.com/tesseract-ocr/tessdata_fast "Modelli linguistici Tesseract tessdata_fast"
