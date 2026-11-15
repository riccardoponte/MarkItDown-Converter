# MarkItDown Desktop 1.5.0

**MarkItDown Desktop** è una GUI Windows per trasformare file, documenti con immagini o pagine scansionate, pagine web, sottotitoli YouTube e immagini in file Markdown. Usa il motore open source [MarkItDown di Microsoft](https://github.com/microsoft/markitdown) come base per i documenti e integra in automatico l'OCR offline multilingua tramite [PaddleOCR (PP-OCRv6)](https://github.com/PaddlePaddle/PaddleOCR) con modelli ONNX locali inclusi in `_internal\ocr\ppocrv6`.

> Questa è una GUI indipendente basata su MarkItDown; non è un prodotto Microsoft ufficiale e non implica affiliazione con Microsoft.

| Elemento | Comportamento |
|---|---|
| Documenti e PDF | Converte i principali formati supportati da MarkItDown in Markdown UTF-8 ed esegue **automaticamente di default l'OCR** sulle pagine PDF scansionate/immagini e sulle immagini incorporate nei documenti. |
| Office e Archivi | Per `.docx`, `.pptx`, `.xlsx`, `.epub` e `.zip`, oltre al testo nativo analizza automaticamente le immagini incorporate ed estrae eventuale testo leggibile in una sezione dedicata (`## Testo OCR da immagini incorporate`). |
| Link web | Scarica soltanto l’URL incollato dall’utente, rimuove menu, banner cookie, pubblicità e altri elementi non utili, quindi salva il testo principale in Markdown. |
| YouTube | Recupera titolo e sottotitoli pubblici, generando righe nel formato `[MM:SS] Testo`. |
| OCR immagini | Legge localmente PNG, JPG, JPEG, WEBP, BMP, TIF e TIFF con **PaddleOCR (PP-OCRv6)** multilingua incluso nell’app (`_internal\ocr\ppocrv6`); non usa LLM né API esterne né download da Internet. |
| EXIF | Riporta formato, risoluzione, modalità colore, DPI e, quando presenti, data e dati della fotocamera. |
| Output | Scrive un file `.md` UTF-8 per ciascun elemento nella cartella scelta. |

## Installazione Windows

Esegui `MarkItDown-Desktop-Setup-1.5.0.exe`. Il setup installa l’app, la cartella `_internal` con tutte le librerie, FFmpeg, `pypdfium2`, `onnxruntime`, `OpenCV` e i modelli locali **PaddleOCR PP-OCRv6** (`det.onnx`, `rec.onnx`, `rec_dict.json`). **Non è necessario installare Python, PaddleOCR o altre dipendenze.**

Nel passaggio **Componenti** puoi attivare anche la voce facoltativa del menu contestuale Windows. L’installazione è per l’utente corrente e non richiede privilegi amministrativi.
