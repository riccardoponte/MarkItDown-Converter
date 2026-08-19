# MarkItDown Desktop 1.3 — Direzione visiva e trascrizione

La versione 1.3 adotta un'interfaccia **chiara, essenziale e originale**, ispirata a principi di leggibilità e gerarchia del riferimento fornito ma senza utilizzare logo, naming, segni distintivi o struttura proprietaria di altri prodotti.

| Elemento | Decisione |
|---|---|
| Fondo applicazione | Avorio tenue `#F7F5F2` |
| Superfici | Bianco caldo `#FFFDFC`, bordi `#E4E0DA` |
| Testo primario | Carbone `#2D2A26` |
| Testo secondario | Grigio caldo `#6D6962` |
| Accento e azioni | Terracotta `#C85D3D`, hover `#A9472F` |
| Titoli | Georgia, per una gerarchia editoriale discreta |
| Contenuti e controlli | Segoe UI, ad alto contrasto e leggibile su Windows |
| Struttura | Intestazione essenziale, area di caricamento prominente, impostazioni compatte, due pannelli chiari per coda e anteprima |
| Iconografia | Simboli UI semplici (`＋`, `⌄`, `↗`) senza emulare marchi terzi |

## Trascrizione media

La lingua parlata è selezionabile nella GUI. Il valore iniziale è **Italiano (`it-IT`)**. Sono disponibili anche Inglese, Spagnolo, Francese, Tedesco e Portoghese. Audio e video vengono convertiti localmente in WAV mono a 16 kHz tramite FFmpeg portabile; la trascrizione viene poi richiesta a Google attraverso `SpeechRecognition` con il codice lingua selezionato.

Per file lunghi, l'audio WAV viene elaborato in segmenti di 55 secondi per ridurre i limiti della richiesta al servizio. I segmenti riconosciuti vengono uniti in un singolo documento Markdown.
