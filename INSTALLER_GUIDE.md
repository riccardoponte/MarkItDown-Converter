# Installatore Windows — MarkItDown Desktop 1.4.1

`MarkItDown-Desktop-Setup-1.4.1.exe` è un installatore per Windows 10/11 a 64 bit destinato all’utente corrente. Durante il setup puoi scegliere la cartella di installazione; il percorso iniziale è `AppData\Local\Programs\MarkItDown Desktop`, ma può essere modificato.

| Elemento installato | Posizione e uso |
|---|---|
| Applicazione | `MarkItDown Desktop.exe` nella cartella scelta. |
| Dipendenze | Sottocartella `_internal` accanto all’app. Non deve essere spostata o eliminata. |
| OCR offline | `_internal\ocr\tesseract.exe` più modelli `ita`, `eng` e `osd`; applica localmente rilevamento automatico del layout e filtro del rumore, senza un’installazione separata di Tesseract. |
| Conversione YouTube | Libreria `youtube-transcript-api` inclusa nell’app. |
| Trascrizione media | `SpeechRecognition`, `pydub` e FFmpeg portabile; Italiano predefinito nel selettore lingua. |
| Script PowerShell | `Install_Context_Menu.ps1` e `Remove_Context_Menu.ps1`. |
| Documentazione | `README.md`, `VERIFICA_BUILD.md`, licenze e guida di installazione. |
| Collegamenti | Menu Start dell’utente corrente e voce di disinstallazione. |

> L’app è autosufficiente: non sono necessari Python, pip, FFmpeg o Tesseract installati separatamente.

## Connessione e privacy

Documenti, conversioni locali e OCR immagini restano sul PC. La funzione **Link web / YouTube** richiede Internet soltanto per scaricare l’URL espressamente incollato dall’utente. La trascrizione audio/video continua a usare `SpeechRecognition` con il servizio Google e quindi richiede Internet; seleziona **Lingua parlata** prima della conversione.

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
