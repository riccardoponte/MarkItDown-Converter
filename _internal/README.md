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
