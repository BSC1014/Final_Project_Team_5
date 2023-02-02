# Final_Project_Team_5 (Project: Fogduckers) 
[![Seattle.png](https://i.postimg.cc/cLFkXZFD/Seattle.png)](https://postimg.cc/PC8MqGsZ)

Link to Presentation: https://docs.google.com/presentation/d/1chuVmRzdd0Rz6CBDThaCUWBZ404QFhylXdZKS13sWS8/edit?usp=sharing

Link to Tableau Dashboard: https://public.tableau.com/app/profile/cristal.urquiza/viz/WhatFactorsAffectReviewScoreRatingsforAirbnbsinSeattle/Story1?publish=yes

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

### Data Storage
The dataset columns were reviewed for relevance and split into seperate tables for any one-to-many relationships. The CSVs were cleaned up as needed to complete the import process into the database. A database diagram was created and Postgres database was created on AWS.

![image](https://user-images.githubusercontent.com/111530580/214310650-2832aa6f-cc3a-471c-bb5b-b4b4c9d1af2a.png)

***
## Machine Learning
***
### Extract Transform Load (ETL.PY File)
***
- Part one of the ETL.PY script was to pull in the data from an AWS postgres sever. It was then transformed into a few data frames namely the "Unit" and the "host" dataframes. Those data frames were then merged to create our main dataframe for our machine learning model. Example below: 

![Screen Shot 2023-02-01 at 10 01 19 PM](https://user-images.githubusercontent.com/111612130/216220908-596f09cf-ae8c-42b3-95e6-87e74e2bb3cb.png)

- Part two was cleaning the table, dropping null values, and getting the data ready for encoding.

- Part three encoded all the strings using one-hot-encoder, this allowed us to not skew the model be encoding using dummies. Example below: 

![Screen Shot 2023-02-01 at 10 02 27 PM](https://user-images.githubusercontent.com/111612130/216221027-0910755c-0acc-4e2c-8e34-c6709a79ad97.png)

- Part four exported the dataframe into an encoded .csv file titled "ml_final_data.csv" to be picked up by our machine learning and neural network models. 

***
### Machine Learning (ML.IPYNB File)
***
- Next, we pulled the "ml_final_data.csv" into our ML model and conducted various tests to help determine if any machine learning model was up to the task of predicting ratings on Air BnBs accurately. Results as follows: 

Oversampling: 

![Screen Shot 2023-02-01 at 10 03 15 PM](https://user-images.githubusercontent.com/111612130/216221101-daa5aa38-5821-428d-b22c-17dd4ab749b4.png)

Smote Oversampling: 

![Screen Shot 2023-02-01 at 10 03 23 PM](https://user-images.githubusercontent.com/111612130/216221109-c98508fa-71c0-4658-8664-546b6d8279ce.png)

Undersampling: 

![Screen Shot 2023-02-01 at 10 03 40 PM](https://user-images.githubusercontent.com/111612130/216221172-571c2778-ef27-462c-a5e4-1dcd1accc799.png)

Combo Sampling: 

![Screen Shot 2023-02-01 at 10 03 50 PM](https://user-images.githubusercontent.com/111612130/216221184-72d0f8c0-7ed3-40a3-aa31-2b84ae310678.png)

Random Forrest: 

![Screen Shot 2023-02-01 at 10 04 22 PM](https://user-images.githubusercontent.com/111612130/216221253-53221496-9736-4408-b18e-dbd073ef3217.png)

Easy Ensemble: 

![Screen Shot 2023-02-01 at 10 04 30 PM](https://user-images.githubusercontent.com/111612130/216221265-3d8f1a19-8ff8-4cf0-953a-7857c4cee8d0.png)

- Considering the above models did not achieve accuracy of greater than our 80% target, we decided to test a Neural Network machine learning model as described in the next section. 
 
 - What was pivotal, however, was the weightings this model displayed which outlined calculated importance of variables towards a good or bad rating: 

![Screen Shot 2023-02-01 at 10 05 11 PM](https://user-images.githubusercontent.com/111612130/216221402-55c5afdd-9e00-4e8b-afc0-1755aa2396f4.png)

***
### Neural Networks and Predicting User Inputs (NN.ipynb & NN_tuner.ipynb files)
***
- Finally we decided to try the Neural Network route. Upon testing we discovered we were able to get accuracy ratings of around 90% with minimal loss which was quite higher than other machine learning models we tried. 
- We were able to achieve this high accuracy rate by tuning the model using keras tuner, example below: 

![Screen Shot 2023-02-01 at 10 06 41 PM](https://user-images.githubusercontent.com/111612130/216221727-0d09c5b8-1dda-4759-ac9e-f6fff67c3e27.png)

- We mirrored the tuning nodes, layers, and activation models as follows: 

![Screen Shot 2023-02-01 at 10 09 23 PM](https://user-images.githubusercontent.com/111612130/216222041-2879673d-3bc4-4c4d-af81-9443fb234cb6.png)

- After tuning the model below is the accuracy we were able to achieve 92% accuracy vs. our test set: 
![Screen Shot 2023-02-01 at 10 13 43 PM](https://user-images.githubusercontent.com/111612130/216222535-599e3ea1-e829-4e0e-9166-a81a91889c93.png)

-We then created a functionality whereby a user could save a CSV file and import it into the model whereby it would make a prediction and save a separate CSV file with the results: 

![Screen Shot 2023-02-01 at 10 13 06 PM](https://user-images.githubusercontent.com/111612130/216222461-c5b8a8ce-0340-458d-8a6d-52391de652ec.png)
***
### Future improvements/lessons learned 
***
- was 90% accurate but predicted all the samples to be good ratings, a more aggressive prediction scheme for 94% ratings lead to a more useful model with 80% accuracy. 



## Process & Communication Protocols 

1. Select a data set: see "Source Data" section for data set. 
2. Decide on question to answer: See "Topic" section for our thesis. 
3. Decide which tools to use: Tools used are Python (for the ETL and ML codes), Postgres/AWS, and potentially vislib or a website for the visualization. 
4. Split up work among team for deliverable 1. *Nathan*
   1. Create ERD for soure data & share it with teammates via AWS. This is done and can be visualized by the above ERD. Additionaly the proof of concept code is done to pull data into python from AWS which will be incorporated into the final code. *Blake & Cristal* 
   2. Clean data as necessary and begin to experiment with machine learning models to answer topic question.  See ETL and ML IPYNB codes for ML testing and data clensing. *Blake and Cristal* 
   3. Create README for project.  *Lane*
   4. Decide on a visual and how to incorporate - *TBD*




