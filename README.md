# Gaza_Conflict
Replication material for the paper "How civilian attitudes respond to the state's violence: Lessons from the Israel-Gaza conflict", with Sami Miaari and Alexei Abrahams

This document guides researchers to replicate the tables and figures in “How civilian attitudes respond to the state's violence: Lessons from the Israel-Gaza conflict” by Amit Loewenthal (amit.loewe@gmail.com) Sami Miaari (samimiaari@tauex.tau.ac.il) and Alexei Abrahams (alexei_abrahams@alumni.brown.edu).

A.	Data Access

All data sources used in this study are owned by external institutions and most are subject to access restrictions that prevent us from depositing the files into any data repository. This section describes how other researchers can apply for access to the data. 

Main data sources: 

1.	Fatalities data
•	Data owner: The Israeli Information Center for Human Rights in the Occupied Territories (B’Tselem)
•	Access: Data can be downloaded from the following site: https://www.btselem.org/statistics

2.	Palestinian labour force survey
•	Data owner: Palestinian Central Bureau of Statistics
•	Access: Access: Researchers can contact PCBS for access (http://www.pcbs.gov.ps/default.aspx#). Researchers can use this data in the PCBS computer lab in Ramallah.

3.	Palestinian Center for Policy and Survey Research public opinion surveys
•	Data owner: Palestinian Center for Policy and Survey Research
•	Access: Researchers can contact PCPSR for access (https://www.pcpsr.org/en/node/764).

B.	Republication Files  

Code folder: This folder contains the following replication .do files: 

•	data_creation.do: This produces the main dataset. 

•	results.do: This generates the tables and figures in the main paper. 

•	appendix.do: This generates the tables and figures in the appendix.

•	gaza_matching.Rmd: This performs a matching algorithm for Table A1

Root path

To run each replication .do file, the user first needs to change the root path to be the path where the replication is stored (e.g. “you-path/Replication files”). All other directories used in the .do files are defined relative to the root path. 

Log folder 

The log folder contains the corresponding log files for each .do file.

ADO files 

Some of our programs may use community-provided commands that may not be installed by default in the user’s State software. If this is the case, please make sure that you download the relevant .ado files. This can be done by typing – findit <command name> – or  – ssc install <command name> –  into the Stata command line. If you already have the relevant command installed but still have problems running the code, you may wish to update the command. You can do this by typing  – ssc install <command name>, replace – into the Stata command line.
