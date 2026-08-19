# Verifica della build — MarkItDown Desktop 1.3.0

La versione **1.3.0** introduce un'interfaccia chiara, minimal e originale, con superfici calde, testo ad alto contrasto e accento terracotta. Il layout privilegia caricamento dei file, cartella di destinazione, lingua parlata, coda e anteprima. Il precedente pulsante **Informazioni** è stato rimosso.

| Controllo | Esito |
|---|---|
| Sintassi e test del motore | Superati con `py_compile`, conversione HTML e gestione dei nomi di output |
| Convertitori documentali | Testati per PDF, DOCX, PPTX, XLSX, TXT, HTML, JSON, IPYNB, EPUB e ZIP |
| Audio-video | Testati WAV e WEBM; FFmpeg normalizza in WAV e il flusso genera Markdown |
| Lingua italiana | Verificato il passaggio esplicito di `it-IT` a `recognize_google(...)` |
| Interfaccia | Screenshot verificato: tema chiaro, selettore Lingua parlata, nessun pulsante Informazioni |
| Installatore | Eseguito in cartella di test; include applicazione, `_internal`, FFmpeg, `SpeechRecognition`, script PowerShell, guida e disinstallatore |

> La trascrizione vocale richiede Internet: i file vengono prima normalizzati localmente con FFmpeg, poi il solo audio viene trasmesso al servizio Google tramite `SpeechRecognition`. Per l'italiano, mantenere **Italiano** nel selettore della lingua.

| Artefatto | Valore |
|---|---|
| Versione | `1.3.0` |
| Setup installatore | `MarkItDown-Desktop-Setup-1.3.0.exe` |
| SHA-256 del setup | Consultare `SHA256SUMS.txt` esterno, per evitare un riferimento autoreferenziale |
| Destinazione | Windows 10/11 a 64 bit |
| Tema | Chiaro, con sistema visivo documentato in `DESIGN_SPEC_1.3.md` |

## Limiti rilevanti

MarkItDown converte il contenuto e la struttura, non l'aspetto grafico originale del documento.[1] Il supporto video estrae e trascrive esclusivamente la traccia audio; non analizza immagini o fotogrammi. Il riconoscimento di audio reale dipende dalla qualità del parlato, dalla lingua selezionata e dalla disponibilità del servizio di trascrizione.

La GUI è stata aperta e acquisita in un runtime desktop locale. La build e l'installatore Windows sono stati verificati nel sandbox; è comunque consigliabile una prova finale su un PC Windows nativo prima dell'uso in produzione.

## Riferimenti

[1]: https://github.com/microsoft/markitdown "Repository ufficiale Microsoft di MarkItDown"
