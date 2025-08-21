/**********************************************************************/
/* Title: REDCap Screening & Randomization Report                     */
/* Description: This script processes de-identified mock screening   */
/* data to generate eligibility and randomization summaries for a    */
/* clinical trial. All data has been de-identified for public use.   */
/**********************************************************************/

/* Step 1: Import mock data exported from REDCap */
proc import datafile="C:\mock_data\screendata_20241009.csv"
    out=data_20241009
    dbms=csv
    replace;
    getnames=yes;
    guessingrows=max;
run;

/* Step 2: Filter to include only screening visit data */
data screendata_20241009;
    set data_20241009;
    if redcap_event_name = 'screening_visit_arm_1';
run;

/* Step 3: Count total number screened */
proc sql;
    select count(*) as total_screened
    from screendata_20241009;
quit;

/* Step 4: Summary of consent status */
proc freq data=screendata_20241009;
    tables consent;
run;

/* Step 5: Summary of patient refusals */
proc freq data=screendata_20241009;
    tables ptrefused;
run;

/* Step 6: Summary of ineligibility */
proc freq data=screendata_20241009;
    tables inelig;
run;

/* Step 7: Identify participants still in screening */
proc sql;
    select count(*) as still_screening
    from screendata_20241009
    where hp_01_screening_randomization_fo = 0;
quit;

/* Step 8: Ineligibility reasons - filtered and grouped */
data inelig_20241009;
    set screendata_20241009;
    if inelig = 1;
    keep inelig pragbp1 pragbp2 preggt23 seccause renal addict more_meds fetaldemise iugr membraner multigest;
run;

data temp;
    set inelig_20241009;

    /* Categorize ineligibility reasons */
    if pragbp2 = 1 then inelcat=1;
    else if preggt23 = 1 then inelcat=2;
    else if seccause = 1 then inelcat=3;
    else if renal = 1 then inelcat=4;
    else if addict = 1 then inelcat=5;
    else if pragbp1 = 1 then inelcat=6;
    else if more_meds = 1 then inelcat=7;
    else if fetaldemise = 1 then inelcat=8;
    else if iugr = 1 then inelcat=9;
    else if membraner = 1 then inelcat=10;
    else if multigest = 1 then inelcat=11;
run;

proc freq data=temp;
    tables inelcat / missing;
run;

/* Step 9: Randomization summary */
proc sql;
    select count(*) as total_randomized
    from screendata_20241009
    where randomized = 1;
quit;

/* Step 10: Average gestational age at randomization */
proc sql;
    select mean(scr_ga) as avg_ga_randomized
    from screendata_20241009
    where randomized = 1;
quit;

/* Step 11: Check if blood pressure dates occurred before estimated pregnancy start date */
data bp_dates;
    set screendata_20241009;

    /* Calculate estimated pregnancy start date */
    start_pregnancy = edd - 280;

    /* Flag blood pressure dates before start of pregnancy */
    BP_Date1_Before = (bp_date1 < start_pregnancy);
    BP_Date2_Before = (bp_date2 < start_pregnancy);
run;

proc freq data=bp_dates;
    tables BP_Date1_Before BP_Date2_Before / missing;
run;
