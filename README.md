# Final_Project_Team_5 (Project: Fogduckers) 
[![Seattle.png](https://i.postimg.cc/cLFkXZFD/Seattle.png)](https://postimg.cc/PC8MqGsZ)

## The Team
 - Cristal 
 - Blake
 - Nathan
 - Lane

## Topic
  Using a data set for vacation rental properties in Seattle, our team aims to use a machine learning model to see if there is correlation between a properties attributes and user reviews.  Are user expieriences based on factors measured with hard data?  Are there underlying reasons for reviews not seen in the numbers? Can seemingly unrelated attributes such as number of bedrooms or bathrooms afffect a score?

## Source Data
The source data - https://www.kaggle.com/datasets/airbnb/seattle - is three csv's and includes information about 3,818 Air B&B listed properties in Seattle WA.  Unit specifics such as number of type of rooms, and neighborhood is included, as well as listing information such as the strictness of the cancellation policy, and wether or not the hosts require a phone verification or guest profile picture.  Importantly the listings aggregated reviews are broken down by category in a 0 to 10 scale, as well as the overall review score in a 0 - 100 scale.
This data was chosen by our team because it was learge enough to perform machine learning algorithms on.  It also appeared to lend itself well to the question we were trying to post of what factors would most influence the reviewers scores.

### Data Categories After Creation of ERD
![image](https://user-images.githubusercontent.com/111530580/214310650-2832aa6f-cc3a-471c-bb5b-b4b4c9d1af2a.png)

## Process & Communication Protocols 

1. Select a data set: see "Source Data" section for data set. 
2. Decide on question to answer: See "Topic" section for our thesis. 
3. Decide which tools to use: Tools used are Python (for the ETL and ML codes), Postgres/AWS, and potentially vislib or a website for the visualization. 
4. Split up work among team for deliverable 1. *Nathan*
   1. Create ERD for soure data & share it with teammates via AWS. This is done and can be visualized by the above ERD. Additionaly the proof of concept code is done to pull data into python from AWS which will be incorporated into the final code. *Blake & Cristal* 
   2. Clean data as necessary and begin to experiment with machine learning models to answer topic question.  See ETL and ML IPYNB codes for ML testing and data clensing. *Blake and Cristal* 
   3. Create README for project.  *Lane*
   4. Decide on a visual and how to incorporate - *TBD*




