# sec_enforcement_db
Tables and Scripts for SEC Enforcement Case Database

Files
-----

- create_enforcement_tables.sql
The base SQL file contains all of the tables for the project.


List of Fields
--------------

Defendant name
Type of defendant (public company, executive, etc.)
Date of case initiation
Citation (Admin. proc. file or litigation release number, etc. Multiple citations per case)
Court or AP (for court put docket number)
Nature of alleged misconduct and violations
Relief sought or settled relief
Admission (boolean)
Parallel case (criminal, federal regulator, state, foreign- more than one is possible, but details are unimportant)
Names of commissioners in favor, disqualified, or against
Settled at initiation (boolean)
Lawyers for defendant
Result at trial (settled, dismissed, summary judgment, etc.)
Distribution fund
Appeal and result
Comments