# sas-redcap-screening-summary
SAS project analyzing screening and randomization data exported from REDCap using de-identified mock data

> ⚠️ No real patient data is included. This is a portfolio sample created using anonymized, synthetic inputs.
>
> # SAS Clinical Trial Data Summary – Screening & Randomization

This SAS project demonstrates how to process and analyze REDCap-exported screening data from a clinical trial. It includes de-identified mock data and showcases key steps such as filtering, summarizing consent and eligibility, and generating summary reports.

## 🔍 Project Goals

- Filter and clean clinical screening data from a REDCap export
- Summarize counts of consented, refused, ineligible, and randomized participants
- Group ineligibility reasons into categories
- Check if BP readings occurred prior to estimated pregnancy start
- Demonstrate use of `PROC IMPORT`, `PROC SQL`, `PROC FREQ`, and `DATA` step logic

## 📦 Files Included

- `screendata_summary.sas` – Main SAS script
- `mock_screening_data.csv` – Synthetic mock data used for demo

## 🧪 Tools & Techniques Used

- SAS Base (no macros required)
- Data cleaning with `DATA` steps
- Frequency tables with `PROC FREQ`
- Conditional logic and calculations
- SQL summarization using `PROC SQL`

## ⚠️ Disclaimer

This project uses **entirely de-identified, synthetic data**. No real patient or HIPAA-protected information is included. The structure mimics real REDCap outputs to demonstrate SAS proficiency.

---

## 🚀 Get Started

If you’d like to run this project:

1. Clone the repo or download the files
2. Open `screendata_summary.sas` in SAS
3. Update the file path to point to your local copy of `mock_screening_data.csv`
4. Run the script to generate summaries and frequency tables



