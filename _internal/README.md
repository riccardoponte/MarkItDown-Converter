# MarkItDown Desktop 1.4.0

**MarkItDown Desktop** è una GUI Windows per trasformare file, pagine web, sottotitoli YouTube e immagini in file Markdown. Usa il motore open source [MarkItDown di Microsoft][1] come base per i documenti e aggiunge flussi locali per OCR e metadati delle immagini.

> Questa è una GUI indipendente basata su MarkItDown; non è un prodotto Microsoft ufficiale e non implica affiliazione con Microsoft.

| Elemento | Comportamento |
|---|---|
| Documenti | Converte i principali formati supportati da MarkItDown in Markdown UTF-8. |
| Link web | Scarica soltanto l’URL incollato dall’utente, rimuove menu, banner cookie, pubblicità e altri elementi non utili, quindi salva il testo principale in Markdown. |
| YouTube | Recupera titolo e sottotitoli pubblici, generando righe nel formato `[MM:SS] Testo`. |
| OCR immagini | Legge localmente PNG, JPG, JPEG, WEBP e BMP con Tesseract incluso nell’app; non usa LLM né API esterne. |
| EXIF | Riporta formato, risoluzione, modalità colore, DPI e, quando presenti, data e dati della fotocamera. |
| Output | Scrive un file `.md` UTF-8 per ciascun elemento nella cartella scelta. |

## Installazione Windows

Esegui `MarkItDown-Desktop-Setup-1.4.0.exe`. Il setup installa l’app, la cartella `_internal` con tutte le librerie, FFmpeg e il motore OCR locale con i modelli italiano e inglese. **Non è necessario installare Python, Tesseract o altre dipendenze.**

Nel passaggio **Componenti** puoi attivare anche la voce facoltativa del menu contestuale Windows. L’installazione è per l’utente corrente e non richiede privilegi amministrativi.

## Uso ordinario

Apri **MarkItDown Desktop**, scegli una cartella di destinazione, aggiungi uno o più elementi e premi **Converti in Markdown**. La coda continua a elaborare gli altri elementi anche se uno produce un errore. L’anteprima visualizza l’ultimo Markdown riuscito; se esiste già un file con lo stesso nome, l’app crea automaticamente `nome (2).md`, senza sovrascrivere il risultato precedente.

| Azione | Come procedere |
|---|---|
| Convertire file | Premi **Scegli file** e aggiungi documenti, media o immagini. |
| Convertire un articolo | Premi **Link web / YouTube**, incolla l’URL di una pagina e premi **Aggiungi link**. |
| Trascrivere un video YouTube | Incolla un URL `youtube.com`, `youtu.be`, `shorts` o `embed`; la lingua selezionata nell’app viene richiesta per prima, con inglese come fallback. |
| Estrarre testo da un’immagine | Aggiungi PNG, JPG, JPEG, WEBP o BMP come un normale file; il risultato contiene una tabella EXIF e la sezione **Testo OCR (offline)**. |

## Link web e YouTube

Il dialogo **Link web / YouTube** è una finestra modale: incolli un solo URL alla volta, lo aggiungi alla coda e lo converti insieme agli altri elementi. Per le pagine web l’app seleziona `article`, `main` o il contenuto principale, eliminando script, barre di navigazione, footer, banner cookie e classi comuni di pubblicità. Il risultato conserva il titolo, la fonte e le sezioni testuali utili.

Per YouTube, l’app usa `youtube-transcript-api` con la sintassi recente `YouTubeTranscriptApi().fetch(...)` e un fallback controllato al precedente `get_transcript`, evitando l’errore `AttributeError` tra versioni della libreria. Il video deve avere sottotitoli pubblici accessibili. YouTube può limitare le richieste da alcune reti, soprattutto reti aziendali, cloud o con proxy: in quel caso l’app mostra un messaggio chiaro e non aggira il blocco con proxy automatici.[2]

> Le conversioni di URL e YouTube richiedono Internet perché recuperano il contenuto che l’utente ha esplicitamente incollato. Non inviano file locali, immagini o contenuti a un’AI.

## OCR immagini senza cloud

L’OCR usa Tesseract 5 incluso e i modelli locali `ita`, `eng` e `osd`. Il file immagine resta sul computer: il testo viene riconosciuto tramite il binario incluso, senza LLM, API OCR o upload cloud. Tesseract richiede sia il motore sia i file `.traineddata` delle lingue; entrambi sono distribuiti nella cartella interna dell’app.[3] [4]

Il Markdown prodotto ha questa struttura:

```markdown
# foto.jpg

## Metadati immagine

| Campo | Valore |
|---|---|
| Risoluzione | 3024 × 4032 px |
| Fotocamera · modello | ... |

## Testo OCR (offline)

Testo riconosciuto…
```

La qualità dipende da nitidezza, contrasto, orientamento e dimensione del testo. Per risultati migliori usa immagini nitide, dritte e con testo sufficientemente grande.

## Audio, video e privacy

L’app può convertire WAV, MP3, M4A, AAC, AIFF, FLAC, OGG, OPUS, MP4, WEBM, MOV, MKV e AVI. FFmpeg normalizza localmente l’audio; per i video viene estratta soltanto la traccia sonora. Il selettore **Lingua parlata** sceglie la lingua della trascrizione.

| Funzione | Dati locali | Rete necessaria |
|---|---|---|
| Documenti e file testuali | Sì | No |
| OCR immagine ed EXIF | Sì | No |
| Conversione di una pagina URL | No, scarica solo la pagina richiesta | Sì |
| Sottotitoli YouTube | No, recupera solo titolo e sottotitoli pubblici | Sì |
| Trascrizione audio/video | Audio normalizzato localmente | Sì, perché usa `SpeechRecognition` con il servizio Google |

Non inserire in URL, screenshot, audio o documenti dati che non sei autorizzato a condividere. Prima di caricare a un’AI i Markdown prodotti, rivedi sempre testo, metadati e contenuti riconosciuti.

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
