# 2019-NHL-Draft-Simulation
Simulation of 2019 NHL Entry Draft

Repository consists of 7 main files. 

	1. SimResultsRaw.csv
		a. A CSV of the raw sim results of my 1 million sims
	2. SimResultsAvg.csv
		a. A CSV of the average pick location of each player
		b. Used in the R scripts
	3. SimResultsCumul.csv
		a. A CSV of the cumulative probability of each player remaining
	4. 2019 Draft Sim - Public.py
		a. The actual simulation
		b. Has been modified to only intake 15 rankings as 2 paywalled rankings were removed
		c. Ensure the rankings are in the same directory (rnk1.txt, rnk2.txt etc) as the script reads these in
    d. There are some comments in this code but it is not overly user-friendly
	5. Rankings.zip
		a. A zip of the txt versions of the rankings
		b. Needs to be exported into the same directory as the sim in order for that to run
	6. 2019DraftSimStats - Public.R
		a. The R script I used to create all the graphs
		b. Consists of a few sections; 
      >The reading of data (ensure data is in source directory)
      > the reshaping of the data
      > the violin plot maker (can edit names manually)
      > the individual graph maker (can edit player manually)
      > the graph iterater (iterates through data frame and charts each player)
	7. Images.zip
    a. A zip folder of the images I used
