# Verifica della build — MarkItDown Desktop 1.5.0

La versione **1.5.0** introduce l’**OCR automatico di default su tutti i documenti** (PDF scansionati, PDF con immagini incorporate, documenti Office `.docx`/`.pptx`/`.xlsx`, `.epub` e `.zip`) oltre alle immagini singole, ed estende il motore Tesseract 5 offline con i **modelli multilingua** (`ita`, `eng`, `fra`, `deu`, `spa`, `por`, `chi_sim`, `jpn`, `osd`).

| Controllo | Esito |
|---|---|
| Sintassi e compilazione Python 3.12 | Superata per `markitdown_desktop.py`, `ocr_conversion.py` e `link_conversion.py`. |
| Self-test eseguibile (`--self-test`) | Superato (`ExitCode: 0`) su `MarkItDown Desktop.exe` v1.5.0. |
| OCR automatico su PDF (`MarkitDown + OCR.pdf`) | Superato: le pagine puramente fotografiche/illustrative prive di testo (Pag. 1 e Pag. 3) vengono filtrate senza rumore, mentre la Pag. 2 (biglietto concerto TicketOne) viene estratta automaticamente come `## Pagina 2 *(OCR)*`. |
| OCR automatico su Office (`.docx`, `.pptx`) | Superato: le immagini incorporate in `word/media/*` e `ppt/media/*` (con associazione automatica al numero di slide) vengono lette via OCR e aggiunte nella sezione `## Testo OCR da immagini incorporate`. |
| Modelli OCR multilingua inclusi | Verificati in `_internal\ocr\tessdata`: `ita`, `eng`, `fra`, `deu`, `spa`, `por`, `chi_sim`, `jpn` e `osd`. |
| Privacy | Pre-elaborazione, rendering PDF (`pypdfium2`), OCR multilingua e filtro anti-rumore restano 100% locali; nessun LLM o API OCR cloud viene usato. |

## Verifica sul PDF reale fornito (`MarkitDown + OCR.pdf`)

| Pagina | Contenuto nel PDF | Esito in MarkItDown Desktop 1.5.0 |
|---|---|---|
| Pagina 1 | Foto ritratto senza testo | Ignorata automaticamente dal filtro anti-rumore (`score = 0.0`). |
| Pagina 2 | Scansione/immagine biglietto TicketOne (Stadio Armando Maradona, Napoli) | Riconosciuta automaticamente (`## Pagina 2 *(OCR)*`) con tutti i dettagli del biglietto (intestazione, data, settore, fila, posto, codici). |
| Pagina 3 | Illustrazione scura senza testo | Ignorata automaticamente dal filtro anti-rumore (`score = 0.0`). |

## Verifiche della distribuzione

La build PyInstaller Windows (`MarkItDown Desktop.exe`) e l'installer NSIS (`MarkItDown-Desktop-Setup-1.5.0.exe`) includono:
- `tesseract.exe` e librerie native in `_internal\ocr`
- Modelli linguistici `ita`, `eng`, `fra`, `deu`, `spa`, `por`, `chi_sim`, `jpn`, `osd` in `_internal\ocr\tessdata`
- Motore `pypdfium2` (`pdfium.dll`) per l'analisi pagina per pagina dei PDF
- Script del menu contestuale Windows e documentazione aggiornata alla versione **1.5.0**.

## Riferimenti

[1]: https://github.com/tesseract-ocr/tessdoc/blob/main/Installation.md "Installazione ufficiale Tesseract"
[2]: https://github.com/tesseract-ocr/tessdata_fast "Modelli linguistici Tesseract tessdata_fast"
