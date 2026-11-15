# Installatore Windows — MarkItDown Desktop 1.5.0

`MarkItDown-Desktop-Setup-1.5.0.exe` è un installatore per Windows 10/11 a 64 bit destinato all’utente corrente. Durante il setup puoi scegliere la cartella di installazione; il percorso iniziale è `AppData\Local\Programs\MarkItDown Desktop`, ma può essere modificato.

| Elemento installato | Posizione e uso |
|---|---|
| Applicazione | `MarkItDown Desktop.exe` (v1.5.0) nella cartella scelta. |
| Dipendenze | Sottocartella `_internal` accanto all’app. Non deve essere spostata o eliminata. |
| OCR offline multilingua (PaddleOCR) | `_internal\ocr\ppocrv6` (`det.onnx`, `rec.onnx`, `rec_dict.json`) + `onnxruntime` + `cv2.pyd` + `pyclipper`: modelli ufficiali **PaddleOCR PP-OCRv6** 100% locali che eseguono automaticamente di default l'OCR su immagini singole, PDF scansionati/con immagini e documenti Office (`.docx`, `.pptx`, `.xlsx`, `.epub`, `.zip`). |
| Rendering PDF | `pypdfium2` (`pdfium.dll`) incluso in `_internal` per ispezionare e renderizzare pagine e oggetti immagine nei PDF senza dipendenze esterne. |
| Conversione YouTube | Libreria `youtube-transcript-api` inclusa nell’app. |
| Trascrizione media | `SpeechRecognition`, `pydub` e FFmpeg portabile; Italiano predefinito nel selettore lingua. |
| Script PowerShell | `Install_Context_Menu.ps1` e `Remove_Context_Menu.ps1`. |
| Documentazione | `README.md`, `VERIFICA_BUILD.md`, licenze e guida di installazione. |
| Collegamenti | Menu Start dell’utente corrente e voce di disinstallazione (`Uninstall.exe`). |

> L’app è autosufficiente: non sono necessari Python, pip, FFmpeg, PDFium o PaddleOCR installati separatamente e non viene scaricato alcun modello da Internet.

## Connessione e privacy

Documenti, PDF (incluso l'OCR automatico tramite PaddleOCR PP-OCRv6 su pagine scansionate e immagini incorporate), file Office e OCR immagini restano interamente sul PC. La funzione **Link web / YouTube** richiede Internet soltanto per scaricare l’URL espressamente incollato dall’utente. La trascrizione audio/video continua a usare `SpeechRecognition` con il servizio Google e quindi richiede Internet; seleziona **Lingua OCR / Audio** prima della conversione.

La conversione YouTube richiede sottotitoli pubblici accessibili. Se YouTube blocca temporaneamente la rete, l’app mostra un errore esplicativo e non utilizza proxy automatici.

## Menu contestuale Windows

Nel passaggio **Componenti** puoi attivare l’opzione facoltativa **Aggiungi il comando al menu contestuale di Windows**. Se selezionata, il setup registra per il solo utente corrente **Converti in Markdown con MarkItDown Desktop**, senza privilegi amministrativi. La voce passa il file scelto alla coda della GUI.

Gli script vengono comunque installati e possono essere eseguiti manualmente dalla cartella dell’app:

```powershell
powershell -ExecutionPolicy Bypass -File .\Install_Context_Menu.ps1
```

Per rimuovere soltanto la voce di menu:

```powershell
powershell -ExecutionPolicy Bypass -File .\Remove_Context_Menu.ps1
```

La disinstallazione rimuove app, collegamenti e voce del menu contestuale relativa all’utente corrente.
