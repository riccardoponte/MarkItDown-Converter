# MarkItDown Desktop 1.3.0

**MarkItDown Desktop** è una GUI locale per convertire documenti in file Markdown. Essa utilizza il motore open source [MarkItDown di Microsoft][1], scaricato dal ramo `main` al commit `fd239d5` (versione della libreria `0.1.7` durante la costruzione). Il repository del motore è rilasciato con licenza **MIT**.[1] [2]

> Questa applicazione è una GUI indipendente, non è un prodotto Microsoft ufficiale e non implica alcuna affiliazione con Microsoft.

| Elemento | Scelta progettuale |
|---|---|
| Motore | `markitdown.MarkItDown`, eseguito localmente |
| Interfaccia | Tema chiaro minimal, con superfici calde, accento terracotta e controlli ad alto contrasto |
| Output | Un file UTF-8 `.md` per ciascun elemento della coda |
| Privacy | Documenti e media restano locali durante la preparazione; la trascrizione vocale richiede il servizio Google di SpeechRecognition |
| Pacchetto | Eseguibile Windows autonomo `MarkItDown Desktop.exe` |

MarkItDown è stato progettato per trasformare file in Markdown preservando struttura utile quali intestazioni, elenchi, tabelle e collegamenti.[1] Il motore dichiara supporto, tra gli altri, per PDF, Word, PowerPoint, Excel, HTML e formati testuali strutturati; il pacchetto incluso nella build abilita i convertitori locali principali per PDF, DOCX, PPTX, XLSX, XLS e Outlook MSG.[1]

## Installatore Windows

Per un'installazione guidata, usare `MarkItDown-Desktop-Setup-1.3.0.exe`. Il setup permette di scegliere la cartella di installazione, copia l'eseguibile insieme alla sottocartella `_internal` contenente tutte le dipendenze locali e installa gli script `Install_Context_Menu.ps1` e `Remove_Context_Menu.ps1`. Nel passaggio **Componenti**, è possibile attivare anche il comando facoltativo del menu contestuale. Per istruzioni dettagliate, leggere `INSTALLER_GUIDE.md`.

## Uso dell'applicazione

Aprire `MarkItDown Desktop.exe`, selezionare **Aggiungi file…**, scegliere una cartella di destinazione e premere **Converti in Markdown**. L'app mantiene una coda dei documenti, mostra lo stato individuale di ciascun elemento e visualizza l'anteprima dell'ultima conversione riuscita. Per evitare sovrascritture, se nella cartella esiste già `documento.md` il risultato successivo verrà salvato come `documento (2).md`.

| Funzione | Comportamento |
|---|---|
| Conversione multipla | Elabora tutti i file della coda in sequenza, continuando anche se un file non riesce |
| Anteprima | Mostra il Markdown dell'ultima conversione completata |
| Salvataggio | Scrive Markdown in UTF-8 con terminatori di riga LF |
| Registro errori | Riporta nel riquadro di anteprima eventuali errori associati a un file |
| Cartella finale | Può aprire automaticamente la destinazione al termine |

L'applicazione utilizza il convertitore standard senza plugin. Le funzionalità di descrizione delle immagini tramite LLM, OCR aggiuntivo via plugin e le integrazioni Azure di MarkItDown non sono attivate: richiedono configurazioni e, in alcuni casi, servizi esterni soggetti a costi.[1]

## Audio, video e lingua

La versione 1.3.0 aggiunge un selettore **Lingua parlata**; il valore iniziale è **Italiano (`it-IT`)** e corregge il riconoscimento dei messaggi vocali italiani. Sono disponibili anche Inglese, Spagnolo, Francese, Tedesco e Portoghese. L'app normalizza localmente in WAV i formati **WAV, MP3, M4A, MP4, AAC, AIFF, FLAC, OGG, OPUS, WEBM, MOV, MKV e AVI** usando FFmpeg portabile; per i video viene estratta la sola traccia audio. I file lunghi vengono elaborati in segmenti da 55 secondi. La trascrizione del parlato viene inviata da `SpeechRecognition` al servizio Google: per questa sola fase è quindi necessaria una connessione Internet. Video privi di audio o file privi di parlato producono un risultato vuoto o un messaggio esplicativo.

## File convertiti e menu contestuale Windows

I risultati non vengono caricati o scaricati da un sito: sono **salvati direttamente** nella cartella di destinazione selezionata nell'app. Per impostazione iniziale, la destinazione è `Documenti\\MarkItDown`; l'opzione **Apri la cartella al termine** è attiva e rende immediatamente disponibili i file `.md` in Esplora file.

La consegna comprende `Install_Context_Menu.ps1`, uno script opzionale che registra, solo per l'utente Windows corrente, il comando **Converti in Markdown con MarkItDown Desktop** nel menu contestuale di qualsiasi file. Conservare lo script nella stessa cartella dell'eseguibile e avviarlo da PowerShell con il comando seguente:

```powershell
powershell -ExecutionPolicy Bypass -File .\Install_Context_Menu.ps1
```

Dopo l'installazione, fare clic destro su un file sul Desktop o in Esplora file, scegliere **Mostra altre opzioni** se necessario e poi **Converti in Markdown con MarkItDown Desktop**. Il file viene inserito automaticamente nella coda della GUI. `Remove_Context_Menu.ps1` rimuove in modo reversibile la voce di menu.

## Contenuto della consegna

| Percorso | Contenuto |
|---|---|
| `dist/MarkItDown Desktop.exe` | Eseguibile Windows, quando generato con la procedura di build |
| `app/markitdown_desktop.py` | Codice sorgente della GUI |
| `markitdown/` | Clone completo del repository ufficiale Microsoft |
| `build_windows.bat` | Ricetta riproducibile per la build su Windows 10/11 |
| `Install_Context_Menu.ps1` | Aggiunge il comando opzionale al menu contestuale di Windows |
| `Remove_Context_Menu.ps1` | Rimuove il comando dal menu contestuale di Windows |
| `tests/test_core.py` | Test non interattivo del motore e della gestione nomi di output |
| `LICENSE_MARKITDOWN.txt` | Testo della licenza MIT del motore MarkItDown |

## Ricompilazione su Windows

Per riprodurre l'eseguibile su Windows 10/11, installare Python 3.10 o superiore e avviare `build_windows.bat` con un doppio clic o da Prompt dei comandi. Lo script crea un ambiente virtuale, installa MarkItDown da `markitdown/packages/markitdown` e le dipendenze locali per documenti comuni, quindi usa PyInstaller per produrre un eseguibile a file singolo.

```bat
cd percorso\di\markitdown_gui
build_windows.bat
```

L'output sarà in `dist\MarkItDown Desktop.exe`. Al primo avvio di un eseguibile a file singolo, Windows può impiegare qualche istante per estrarre i componenti in una cartella temporanea. Se SmartScreen richiede una verifica, controllare che il file provenga dalla consegna originale o ricompilare localmente con lo script incluso; non disattivare le protezioni del sistema per file di provenienza ignota.

## Limiti noti

L'accuratezza dipende dal contenuto e dal formato sorgente. MarkItDown dichiara espressamente di essere destinato a pipeline di analisi testuale e LLM, non alla riproduzione visiva ad alta fedeltà di un documento.[1] Le conversioni audio possono richiedere componenti di sistema aggiuntivi non inclusi, quali decoder multimediali. Le scansioni PDF complesse potrebbero non contenere testo recuperabile localmente.

## Riferimenti

[1]: https://github.com/microsoft/markitdown "microsoft/markitdown — repository ufficiale"
[2]: https://github.com/microsoft/markitdown/blob/main/LICENSE "Licenza MIT di MarkItDown"
