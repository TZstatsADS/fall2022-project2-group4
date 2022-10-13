# Project 2: Shiny App Development

### [Project Description](doc/project2_desc.md)

<img src="figs/GitHub.PNG" width="500">

In this second project of GR5243 Applied Data Science, we develop an *Exploratory Data Analysis and Visualization* shiny app on motor vehicle crash data collected by the **NYPD** released on [NYC Open Data](https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95). In particular, our project aims to analyze the effect of COVID-19 on the rate of traffic accidents and on the rate of severe accidents in NYC.  

The **learning goals** for this project is:

- business intelligence for data science
- data cleaning
- data visualization
- systems development/design life cycle
- shiny app/shiny server

## NYC Vehicle Collision Analysis from 2019 to Present
Term: Fall 2022

+ Team #4
+ Team members:
	+ Alix Leon
	+ Kartik Kotian
	+ Samira Kamal
	+ Yizhou Zhao
	+ Gabriel Spade

+ **Project summary**: This project aims to analyze the rate of motor vehicle crashes and their severity before, during, and after the COVID-19 lockdowns in New York City. To this end, we built a Shiny App in R using data collected by the NYPD available on NYC Open Data. Our findings demonstrate the relationship between traffic density and fatal accidents found in [Shefer and Rietveld, 1997](https://doi.org/10.1080/0042098975970).

+ **Contribution statement**: The entire team selected the dataset and project topic. Alix Leon built the entire Shiny App and data pipeline. Kartik Kotian designed the overall data story structure, wrote the jupyter notebook analyses, gathered research papers to support all claims and the presentation. Gabriel Spade organized and maintained the repository, updated the README files, added axes and titles to graphs for the App.

This folder is organized as follows.

```
proj/
├── app/
├── lib/
├── data/
├── doc/
├── output/
```

Please see each subfolder for a README file.

Note: global.R contains the code for running the Shiny App
