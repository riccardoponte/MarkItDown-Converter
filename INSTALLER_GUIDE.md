# Installatore Windows — MarkItDown Desktop 1.3.0

`MarkItDown-Desktop-Setup-1.3.0.exe` è un installatore Windows per utente corrente. Durante l'installazione visualizza la pagina di scelta della cartella; il percorso iniziale proposto è `AppData\Local\Programs\MarkItDown Desktop`, ma può essere modificato prima di confermare.

| Elemento installato | Posizione |
|---|---|
| Applicazione | `MarkItDown Desktop.exe` nella cartella scelta |
| Dipendenze e modelli locali | Sottocartella `_internal` accanto all'applicazione |
| Script PowerShell | `Install_Context_Menu.ps1` e `Remove_Context_Menu.ps1` nella cartella scelta |
| Trascrizione media | `SpeechRecognition`, `pydub` e FFmpeg portabile; lingua selezionabile, Italiano predefinito |
| Documentazione e licenza | `README.md`, `VERIFICA_BUILD.md`, `LICENSE_MARKITDOWN.txt` |
| Collegamenti | Menu Start dell'utente corrente |
| Disinstallazione | Voce di Windows Installate apps e collegamento nel menu Start |

> Non spostare né eliminare `_internal`: contiene le librerie Python, i convertitori, il binario FFmpeg e i modelli di riconoscimento necessari all'eseguibile.

Per le trascrizioni vocali, l'app invia l'audio normalizzato al servizio Google tramite `SpeechRecognition`; è quindi richiesta una connessione Internet. Nel pannello principale scegliere **Lingua parlata** prima di convertire: Italiano (`it-IT`) è il valore iniziale. Per i file video viene elaborata soltanto la traccia audio.

Nel passaggio **Componenti** puoi scegliere facoltativamente **Aggiungi il comando al menu contestuale di Windows**. Se selezionato, il programma di installazione registra per il solo utente corrente il comando **Converti in Markdown con MarkItDown Desktop**, senza richiedere privilegi amministrativi. Il comando passa il file selezionato alla GUI, che lo carica automaticamente nella coda.

Lo script `Install_Context_Menu.ps1` viene installato in ogni caso, anche se non selezioni il componente nel setup. Può quindi essere eseguito manualmente in un secondo momento dalla cartella dell'app:

```powershell
powershell -ExecutionPolicy Bypass -File .\Install_Context_Menu.ps1
```

Per rimuovere esclusivamente la voce di menu contestuale, esegui:

```powershell
powershell -ExecutionPolicy Bypass -File .\Remove_Context_Menu.ps1
```

La disinstallazione dell'app rimuove sia i file installati sia la chiave del menu contestuale creata per l'utente corrente.
