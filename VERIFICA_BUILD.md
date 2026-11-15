# Verifica della build — MarkItDown Desktop 1.5.0

La versione **1.5.0** introduce l’**OCR automatico di default su tutti i documenti** (PDF scansionati, PDF con immagini incorporate, documenti Office `.docx`/`.pptx`/`.xlsx`, `.epub` e `.zip`) oltre alle immagini singole, e sostituisce il motore OCR con **PaddleOCR (PP-OCRv6)** eseguito interamente in locale tramite modelli ONNX inclusi in `_internal\ocr\ppocrv6`.

| Controllo | Esito |
|---|---|
| Sintassi e compilazione Python 3.12 | Superata per `markitdown_desktop.py`, `ocr_conversion.py` e `link_conversion.py`. |
| Self-test eseguibile (`--self-test`) | Superato (`ExitCode: 0`) su `MarkItDown Desktop.exe` v1.5.0 con verifica presenza modelli locali `ppocrv6`. |
| Motore OCR locale | **PaddleOCR PP-OCRv6** (`PP-OCRv6_small_det` + `PP-OCRv6_small_rec`) in `_internal\ocr\ppocrv6` (`det.onnx`, `rec.onnx`, `rec_dict.json` con 18.708 caratteri multilingua), zero chiamate di rete. |
| OCR automatico su PDF (`MarkitDown + OCR.pdf`) | Superato: le pagine puramente fotografiche/illustrative prive di testo vengono filtrate senza rumore, mentre la pagina con il biglietto concerto TicketOne viene estratta automaticamente come `## Pagina 2 *(OCR)*` con ricostruzione geometrica di righe e colonne. |
| OCR automatico su Office (`.docx`, `.pptx`) | Superato: le immagini incorporate in `word/media/*` e `ppt/media/*` (con associazione automatica al numero di slide) vengono lette via PaddleOCR e aggiunte nella sezione `## Testo OCR da immagini incorporate`. |
| Privacy | Pre-elaborazione, rendering PDF (`pypdfium2`), inferenza ONNX PaddleOCR PP-OCRv6 e ricostruzione layout restano 100% locali; nessun download runtime né API OCR cloud viene usato. |

## Verifica sul biglietto TicketOne (`MarkitDown + OCR.pdf` — Pagina 2)

| Elemento nel biglietto | Riconoscimento PaddleOCR PP-OCRv6 locale |
|---|---|
| Intestazione ed emittente | `ticketone`, `TicketOne S.p.A.`, `MAGELLANO CONCERTI`, `eventim` |
| Intestatario | `Ana Paula Martinelli` |
| Data, ora e luogo | `Giovedì 10 Giugno 2027 Ora: 21:00`, `Stadio Armando Maradona, Napoli` |
| Settore e posto | `Ingresso: Gate 22 - 25`, `Curva A Superiore A22`, `Fila 21 posto 10`, `Intero` |
| Dati fiscali e codici | `C.f Tit: 123456789`, `C.f Org: 123456789`, `S.F: 123456789abcd`, `ID Sistema: 0000000`, `Progressivo: 12345`, `Data/ora: 31/dic/2050 00:00`, `Cod.Richi.En.: Sigillo XX00000` |

## Verifiche della distribuzione

La build PyInstaller Windows (`MarkItDown Desktop.exe`) e l'installer NSIS (`MarkItDown-Desktop-Setup-1.5.0.exe`) includono:
- Modelli ONNX ufficiali **PaddleOCR PP-OCRv6** (`det.onnx`, `rec.onnx`, `rec_dict.json`, `det.yml`, `rec.yml`) in `_internal\ocr\ppocrv6`
- Runtime nativi `onnxruntime`, `cv2.pyd` (OpenCV) e `pyclipper` in `_internal`
- Motore `pypdfium2` (`pdfium.dll`) per l'analisi e il rendering pagina per pagina dei PDF
- Script del menu contestuale Windows e documentazione aggiornata alla versione **1.5.0**.

## Riferimenti

[1]: https://github.com/PaddlePaddle/PaddleOCR "Repository ufficiale PaddleOCR (PP-OCRv6)"
[2]: https://github.com/microsoft/markitdown "Repository ufficiale Microsoft di MarkItDown"
