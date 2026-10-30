# FR 2052a Instructions (Markdown)

The FR 2052a Complex Institution Liquidity Monitoring Report instructions,
transcribed from the source PDF into Markdown so that the regulation text can
be read, searched, diffed and linked alongside the Elm modules that implement
it in [`src/Regulation/US/FR2052A/`](../../src/Regulation/US/FR2052A/).

**The PDF remains authoritative.** This transcription is a convenience copy. If
the two disagree, the PDF is right and the file here is a bug.

## Source

- FR 2052a Instructions, revision dated **2025-02-26** (approved through
  February 2028), file `FR_2052a20250226_f.pdf`: 106 pages of instructions plus
  three appended mapping documents (Appendices VI, VII and VIII) that carry
  their own page numbering.
- Current forms and instructions are published on the Federal Reserve's
  [FR 2052a report page](https://www.federalreserve.gov/apps/reportingforms/Report/Index/FR_2052a).
  The Board rotates the PDF URL with each revision, so no direct link is given
  here.
- As a work of the United States government, the instructions are not subject
  to copyright protection in the U.S. (17 U.S.C. § 105).

Note that [`doc/README.md`](../README.md) describes the Morphir mapping against
the earlier 2022-04-29 revision. Where the two revisions differ, this folder
reflects the newer text.

## Contents

| File | Covers |
| --- | --- |
| [`01-general-instructions.md`](01-general-instructions.md) | Purpose, confidentiality, who must report, rules of consolidation, submission frequency and timing, what must be reported |
| [`02-field-definitions.md`](02-field-definitions.md) | Every reportable field and its data constraints |
| [`03-product-definitions/`](03-product-definitions/) | The 13 data tables, one file per table group |
| [`04-appendices/`](04-appendices/) | Appendices I through VIII |

The product-definition files follow the report's own table codes, which line up
one-to-one with the Elm modules under `src/Regulation/US/FR2052A/DataTables/`:
`I.A`/`I.S`/`I.U`/`I.O` for inflows, `O.D`/`O.S`/`O.W`/`O.O` for outflows, and
`S.B`/`S.DC`/`S.FX`/`S.I`/`S.L` for the supplemental tables.

The appendices are the ones worth knowing by number: **I** data format, tables
and fields; **II-a** through **II-d** the Product/Sub-Product, Counterparty and
Collateral Class requirements plus the forward-start exclusions; **III** the
asset category table; **IV-a** and **IV-b** the maturity bucket value list and
its tailoring by firm category; **V** double counting of certain exposures; and
**VI**, **VII** and **VIII** the mappings from the LCR rule, the FR Y-15 STWF
indicator and the NSFR to FR 2052a data identifiers.

## How this was produced

The PDF is born-digital — its text is real Unicode rather than scanned pixels —
so no OCR was involved. The general instructions, field definitions and product
definitions were split out of the extracted text by a deterministic script,
which keeps the transcription reproducible and traceable rather than resting on
a model's output. Every appendix was then curated by hand, because the
appendices carry the tabular content that no heading-based splitter can
reconstruct: tables spanning page breaks, multi-column value lists, and
diagrams.

Two places needed more than transcription, and each says so in a note at the
top of the file. The LCR and NSFR formulas in Appendices VI and VIII are set in
Cambria Math font subsets whose ToUnicode CMap is broken, so their text cannot
be extracted at all; those formulas were transcribed from 12 CFR 249 and the
visible structure of the document. The maturity-mismatch formulas on page 110
are purely graphical and were transcribed by eye.

Where a hand edit departs from the source — a corrected typo, a renamed column
header, a mislabelled heading — the file records it in a footnote at the point
of the change.
