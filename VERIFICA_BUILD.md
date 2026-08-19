# Verifica della build — MarkItDown Desktop 1.4.1

La patch **1.4.1** corregge l’OCR locale di immagini con fumetti, chat, poster o testo sovrapposto a una scena fotografica. La versione precedente applicava `--psm 6`, che trattava l’intera immagine come un solo blocco di testo e produceva rumore dai volti, bordi e sfondo.

| Controllo | Esito |
|---|---|
| Sintassi Python | Superata per GUI, OCR, URL/YouTube e script di build. |
| Test automatici | **12 test superati**: formati/EXIF, pulizia del rumore, layout URL, sintassi YouTube recente e legacy, coda mista file/URL. |
| Nuovo OCR | Scala di grigi, autocontrasto, lieve contrasto aggiuntivo e rilevamento automatico del layout con Tesseract `--psm 3`. |
| Filtro locale | Elimina righe isolate con meno di tre caratteri alfanumerici e artefatti decorativi ai bordi dei fumetti. |
| Prova Windows reale | Eseguita sul JPEG fornito: il risultato conserva le tre nuvolette e rimuove le numerose righe spurie precedenti. |
| Privacy | Pre-elaborazione, OCR e filtro restano 100% locali; nessun LLM o API OCR viene usato. |

## Confronto sul caso fornito

| Prima: modalità a blocco singolo | Dopo: layout automatico e filtro |
|---|---|
| Numerose righe come `ms, i @." i e pa Ò 7`, `vel Tai o e`, `si OS jana Gee`, `PA Li` e simboli isolati. | Le righe di rumore visivo vengono rimosse; restano i tre messaggi dei fumetti in ordine di lettura. |
| Il testo dei fumetti è mescolato con volti, bordi e texture della scena. | La segmentazione automatica tratta le nuvolette come blocchi separati. |

Il risultato OCR corretto ottenuto con il motore Windows incluso è:

```text
Ragazzi scusatemi, ma oggi mi è
vetiuto vogiva di rillazarmi alle terme.
dubbiamo rimandare
Oh no ragazzi oggi devo andare
assolatsmente alla fiéra... disdico all
ultimo pérò ci sentiamo
Eh piccato, ho tuitti i linfonodi
ingrossati... sto da schifo.... sara per
un'altra volta
```

> L’OCR offline non è un correttore ortografico e non può ricostruire con certezza lettere ambigue o testo generato artificialmente nell’immagine. La correzione rimuove il rumore e migliora molto la struttura; alcune lettere simili, come `l`/`i` o `o`/`a`, possono restare imprecise.

## Verifiche della distribuzione

La build PyInstaller Windows include Tesseract, librerie native e modelli `ita`, `eng` e `osd`. L’installer NSIS della patch viene ricreato dopo questa verifica. Il controllo finale deve confermare presenza di `tesseract.exe`, modelli e guide aggiornate nella directory installata.

## Riferimenti

[1]: https://github.com/tesseract-ocr/tessdoc/blob/main/Installation.md "Installazione ufficiale Tesseract"
[2]: https://github.com/tesseract-ocr/tessdata_fast "Modelli linguistici Tesseract"
