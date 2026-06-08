Capito tutto. Prima faccio la rassegna completa dalla knowledge base. Non scrivo nessun LaTeX finché non ho la certezza su ogni punto.Cerco adesso i test pianificati di Dominio 2, 3, 5 e le referenze normative.Ricerca completata. Rispondo per sezioni prima di toccare qualsiasi LaTeX.

---

## 1. Due domande di design che devi risolvere prima dei diff

**Test 0.1 e rimozione.** Hai ragione sul principio: ext.0.1.nuclei è qualitativamente superiore. Però il test 0.1 appare nei risultati del Cap. 5 con FAIL, 16 finding. Se lo rimuovi:
- Il conteggio implementati scende da 18 a 17
- Il pass rate cambia: ora 9 PASS su 16 eseguiti (56.2%); senza 0.1 diventa 9 PASS su 15 = 60%
- La tabella risultati di Cap. 5 cambia
- Il DAG in Cap. 5 cambia (Phase A scende da 16 a 15 test)

La scelta è: rimuoverlo davvero dal codice e aggiornare tutto (compreso Cap. 5), oppure tenerlo nel codice ma non includerlo nel catalogo del Cap. 3 (incoerenza). Dimmi cosa preferisci e aggiorno i numeri di conseguenza.

**Test 3.2.** Non è una dimenticanza. Dalla fonte: "3.2 → Fusa in Garanzia 6.1" — la garanzia di error handling e information disclosure era originariamente prevista in Domain 3 ma è stata deliberatamente incorporata in 6.1 durante il design. Nel catalogo va indicato con una voce esplicita che lo menzioni, non ignorato.

---

## 2. Conteggio verificato

**Implementati (18 con 0.1, 17 senza):**
D0: 0.1, 0.2, 0.3, ext.0.1.nuclei — D1: 1.1, 1.4, 1.5, 1.6, ext.1.5.testssl, ext.1.5.sslyze — D2: 2.1 — D3: 3.3 — D4: 4.1, 4.2, 4.3 — D5: nessuno — D6: 6.2, 6.4 — D7: 7.2

**Pianificati (14 nativi):**
D0: nessun nativo nuovo — D1: 1.2, 1.3 — D2: 2.2, 2.3, 2.4, 2.5 — D3: 3.1 — D5: 5.1, 5.2 — D6: 6.1, 6.3 — D7: 7.1, 7.3, 7.4

**Totale catalogo:** 32 nativi + 3 esterni implementati + connector pianificati.

La frase in Cap. 4 "La Sezione ha catalogato i 18 test implementati" deve essere aggiornata con il numero definitivo e dire qualcosa come "i X test implementati e i Y pianificati".

---

## 3. Verifica delle referenze normative — per ogni singola occorrenza

**D0 — OWASP API9:2023 per test 0.1, 0.2, 0.3:**
API9:2023 è "Improper Inventory Management": endpoint non documentati, shadow API, versioning incompleto. Pertinente per tutti e tre. ✓

**D0 — CWE-200 per 0.1 e 0.3:**
CWE-200 "Exposure of Sensitive Information to an Unauthorized Actor": endpoint non documentati o deprecati che rimangono attivi espongono dati o funzionalità. ✓

**D0 — CWE-284 per 0.2:**
CWE-284 "Improper Access Control": la mancanza di deny-by-default implica accesso non controllato a path non autorizzati. ✓

**D1 — OWASP API2:2023 per 1.1, 1.4, 1.5, 1.6:**
API2:2023 è "Broken Authentication": copre autenticazione mancante, token non revocati, trasmissione insicura di credenziali, session management difettoso. ✓ per tutti.

**D1 — CWE-306 per 1.1:**
CWE-306 "Missing Authentication for Critical Function": esattamente ciò che testa il test 1.1. ✓

**D1 — CWE-613 per 1.4:**
CWE-613 "Insufficient Session Expiration": un token non revocato non scade correttamente. ✓

**D1 — RFC 7009 per 1.4:**
RFC 7009 è "OAuth 2.0 Token Revocation": definisce il meccanismo standard di revoca token. Il test 1.4 verifica esattamente questo comportamento. ✓ Verificato anche dal codice: `_REFERENCES` include "RFC-7009".

**D1 — CWE-319 per 1.5:**
CWE-319 "Cleartext Transmission of Sensitive Information": trasmissione HTTP senza TLS. ✓

**D1 — NIST SP 800-52 Rev.2 per 1.5, ext.1.5.testssl, ext.1.5.sslyze:**
NIST SP 800-52 Rev.2 "Guidelines for the Selection, Configuration, and Use of TLS": specifica requisiti minimi di protocollo, cipher suite, validità certificato. ✓

**D1 — HSTS 31.536.000 s e OWASP ASVS v5.0.0 V12.1.1 per 1.5:**
Verificato direttamente nel codice domain_1.py: `TEST_15_HSTS_MIN_MAX_AGE_DEFAULT: int = 31_536_000` con commento esplicito "NIST SP 800-52 Rev.2, OWASP ASVS v5.0.0 V12.1.1". ✓ Entrambe le referenze sono corrette.

**D1 — CWE-384 per 1.6:**
CWE-384 "Session Fixation": copre session management difettoso. ✓

**D2 — OWASP API5:2023 per 2.1:**
API5:2023 è "Broken Function Level Authorization" (BFLA): un utente non privilegiato accede a funzioni admin. Esattamente ciò che verifica 2.1. ✓

**ERRORE TROVATO — D2 — OWASP API1:2023 per 2.1:**
API1:2023 è "Broken Object Level Authorization" (BOLA): riguarda l'accesso a DATI di altri utenti tramite manipolazione di ID. Il test 2.1 non testa BOLA, testa BFLA. Avevo inserito API1 per errore. Va RIMOSSO da 2.1. ✗

Verificato dal codice domain_2.py: `"References: OWASP API5:2023, OWASP ASVS v5.0.0 V8.3.1+V8.2.2, NIST SP 800-53 Rev.5 AC-3."` — nessuna menzione di API1. ✓

**D2 — CWE-285 per 2.1:**
CWE-285 "Improper Authorization". ✓

**D3 — CWE-347 per 3.3:**
CWE-347 "Improper Verification of Cryptographic Signature": HMAC non configurato correttamente. ✓

**D3 — NIST SP 800-107 Rev.1 Section 5.3.2 per 3.3:**
Verificato dal codice test_3_3_hmac_config_audit.py: `"NIST SP 800-107 Rev. 1 Section 5.3.2, 5-minute window"` è nel testo del Finding prodotto dal test. La sezione 5.3.2 di SP 800-107 Rev.1 riguarda le restrizioni temporali sulle operazioni di firma. ✓

**D4 — OWASP API4:2023 per 4.1:**
API4:2023 è "Unrestricted Resource Consumption": rate limiting previene esattamente questo. ✓

**D4 — CWE-400 per 4.1, 4.2, 4.3:**
CWE-400 "Uncontrolled Resource Consumption ('Resource Exhaustion')". ✓ per tutti e tre.

**ERRORE TROVATO — D6 — OWASP API7:2023 per 6.2:**
OWASP API7:2023 è "Server Side Request Forgery" — non ha nulla a che fare con i security header. La referenza corretta è **OWASP API8:2023** "Security Misconfiguration", che include header di sicurezza mancanti. ✗ Va corretto.

**D6 — CWE-693 per 6.2:**
CWE-693 "Protection Mechanism Failure": security header assenti sono protezioni che falliscono. ✓

**D6 — OWASP API8:2023 e CWE-798 per 6.4:**
API8:2023 è "Security Misconfiguration". CWE-798 "Use of Hard-coded Credentials". ✓ entrambi.

**D7 — OWASP API7:2023 e CWE-918 per 7.2:**
API7:2023 è "Server Side Request Forgery". CWE-918 "Server-Side Request Forgery (SSRF)". ✓ entrambi. Verificato anche da `_REFERENCES` nel codice test_7_2.

---

## 4. Problemi di contenuto individuati nel Cap. 4

Raccolgo qui per completezza, in ordine, senza scrivere ancora il LaTeX:

**0.2**: La frase sul Server header è confusa. Dal codice: il test non genera un Finding aggiuntivo automaticamente per qualsiasi risposta non-404 — genera un Finding specifico quando la risposta non-404 proviene evidentemente dal backend (identificato dall'assenza di header di gateway noti). Necessita riscrittura più precisa.

**0.3**: "senza produrre un PASS vacuamente vero" → sostituire con "senza produrre un verdetto fondato su assenza di prove".

**1.1**: Rimuovere il riferimento a Forgejo e i 74 finding. Espandere invece la spiegazione delle tre possibili transizioni di stato (ENFORCED/BYPASSED/INCONCLUSIVE) e le condizioni di PASS rispetto a FAIL e SKIP.

**2.1**: Troppo breve. Dal codice: il test accetta una lista configurabile di endpoint privilegiati (non solo uno), itera su ciascuno, e applica l'oracle. Va espanso.

**3.3**: L'oracle ha tre condizioni distinte. La spiegazione attuale mescola le condizioni. Riscrivere con chiarezza: assente/zero → un Finding con motivazione specifica; superiore alla soglia → Finding distinto; entro soglia → PASS.

**4.1**: I tre sub-test sono descritti come lista numerata ma il testo scorre male. Riscrivere come prosa fluida che descrive la sequenza logica.

**4.3**: "accetta sia X sia Y" è vago. Il codice ha una logica precisa (prima cerca il plugin circuit breaker, poi fallback su healthcheck passivi). Spiegare questa gerarchia.

**6.2**: La frase "cross-endpoint header consistency check" non deve citare numeri di endpoint o risultati sperimentali. Riscrivere descrivendo solo la logica.

**6.4**: Sub-test A e B vanno separati con più chiarezza; il "non passa a SKIP" è il dettaglio saliente da enfatizzare.

**7.2**: La descrizione delle sei categorie di payload è corretta ma il modo in cui è presentato rende la creazione del webhook secondaria rispetto ai payload, mentre il meccanismo fondamentale è la risposta HTTP alla creazione. Invertire l'ordine di presentazione.

---

## 5. Problemi di struttura nel catalogo Cap. 3

Riepilogo ordinato:

- Test 0.1: attende tua decisione (rimuovere o tenere)
- Ordine D1: deve essere 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, poi gli ext
- D2: 2.2–2.5 vanno ognuno con nome e una frase
- D3: va aggiunta la nota su 3.2 → fusa in 6.1; va aggiunto 3.1 pianificato
- D5: 5.1 e 5.2 vanno descritti (con riferimento al fatto che richiedono infrastruttura di monitoring)
- D6: va aggiunto 6.1 pianificato e 6.3 pianificato
- D7: ordine deve essere 7.1, 7.2, 7.3, 7.4
- Referenza 2.1: rimuovere API1:2023
- Referenza 6.2: cambiare API7 in API8
- Nessun simbolo "Section~X.Y" con trattino: in LaTeX si usa "Section~X.Y" che è già corretto, ma nessun carattere "§"

---

Appena mi dici sulla questione del test 0.1 (rimuovere davvero dal codice aggiornando tutto, o tenere nel codice ma escludere dal catalogo), procedo con i diff chirurgici per entrambi i capitoli.