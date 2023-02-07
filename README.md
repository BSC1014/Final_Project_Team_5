# Final_Project_Team_5 
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

### ML Future improvements/lessons learned 
***
- was 90% accurate but predicted all the samples to be good ratings, a more aggressive prediction scheme for 94% ratings lead to a more useful model with 80% accuracy. 

### Data Cleaning/ ETL
Data was cleaned from the original three csv's that was provided from the Kaggle Seattle Data: https://www.kaggle.com/datasets/airbnb/seattle

It was imported, and then the info, the nulls, and the mean of the nulls was checked to gather as much information about each csv: 

<img width="494" alt="Screen Shot 2023-02-01 at 7 34 25 PM" src="https://user-images.githubusercontent.com/109998935/216205167-2e1bae0f-8869-4358-827f-049f26787e85.png">

<img width="448" alt="Screen Shot 2023-02-01 at 7 34 34 PM" src="https://user-images.githubusercontent.com/109998935/216205196-60097f29-0d0c-457c-9d82-931cabd81b08.png">

<img width="272" alt="Screen Shot 2023-02-01 at 7 34 44 PM" src="https://user-images.githubusercontent.com/109998935/216205288-d3b53bd7-42e9-4d2a-9fcd-1007ea21834e.png">

<img width="469" alt="Screen Shot 2023-02-01 at 7 34 50 PM" src="https://user-images.githubusercontent.com/109998935/216205316-528099cc-2b77-4a03-b0d4-12eb01af2ea0.png">

Next, columns were dropped based on what columns would be used to be analyzed visually, or through our machine learning model and neural network. 

<img width="964" alt="Screen Shot 2023-02-01 at 7 36 04 PM" src="https://user-images.githubusercontent.com/109998935/216205758-e26c4f0b-f1ba-4bb9-b0cf-91906c4fdb54.png">

My listings csv file was my largest csv file, and there were many different columns which added many different dtypes and null values. After columns were dropped that were not being used, null values were checked:

<img width="592" alt="Screen Shot 2023-02-01 at 7 36 34 PM" src="https://user-images.githubusercontent.com/109998935/216205913-e5ce31fd-310d-48aa-8ef2-baebd7d86dfc.png">

With this information, I checked the info and determined which columns had to change and become datetime dtypes, which columns had to come floats or integers. Extra things such as '$' or '%' were also dropped to help clean the data further.

<img width="854" alt="Screen Shot 2023-02-01 at 7 37 00 PM" src="https://user-images.githubusercontent.com/109998935/216206163-d042fe80-0437-4fb2-8322-28f6950af8d9.png">

Next, columns were filled according to the mean of the column or through the 'ffill' option:

<img width="848" alt="Screen Shot 2023-02-01 at 7 37 39 PM" src="https://user-images.githubusercontent.com/109998935/216206317-9067fd4d-c815-4ceb-9e25-e0533f0a892d.png">

<img width="633" alt="Screen Shot 2023-02-01 at 7 38 06 PM" src="https://user-images.githubusercontent.com/109998935/216206373-aaea4599-bb39-427a-8555-b0f0ba17ed66.png">

The zip-code column needed extra cleaning to be filled, to then be converted to a float from an object, and then once again from a float to an integer. 

<img width="854" alt="Screen Shot 2023-02-01 at 7 38 19 PM" src="https://user-images.githubusercontent.com/109998935/216206504-5a5979f3-2f25-47dd-bd92-9a6841f03440.png">

True and False columns were also cleansed by converting T/F to 0/1 to be able to use it with analysis: 

<img width="808" alt="Screen Shot 2023-02-01 at 7 38 41 PM" src="https://user-images.githubusercontent.com/109998935/216206630-f924fe32-0ff5-4fb8-8501-10a0166b44a8.png">


Some columns were left with nulls that were not going to be used because of how much missing data that was, which led us to believe it would not be worth using since so much was missing: 

<img width="330" alt="Screen Shot 2023-02-01 at 8 17 14 PM" src="https://user-images.githubusercontent.com/109998935/216207465-bfaebece-4d24-4ed9-86cc-102dcab425a9.png">

At the end, a cleaned csv file was created for the listing file since that was the main csv that was going to be used to analyze visually: 

<img width="625" alt="Screen Shot 2023-02-01 at 7 38 50 PM" src="https://user-images.githubusercontent.com/109998935/216207604-30d5dcee-b780-4565-8c3d-c00e76137eed.png">

In the future, further assessment could be done to use loc and iloc to figure out using the comments for transit for example had a factor for a higher rating score. 

## Tableau Visualizations

Link for the story board on Tableau Public: https://public.tableau.com/app/profile/cristal.urquiza/viz/WhatFactorsAffectReviewScoreRatingsforAirbnbsinSeattle/Story1?publish=yes

The data was visualized to demonstrate which factors affected rating scores or didn't. The first story board was seeing if Price and Availability by Zip-code had an affect with Review Score Ratings which was filtered by color. It was filtered to show which had a rating of 90 or above which can be seen in the legend. You can see certain zip-codes have more availability than others, but most all of the zip-codes are largely scored 90 and above. Further analysis can be done to see if the zip-codes that have lower availability are constantly being booked, and what is the attraction to that location, and if that contributes to the user experience wanting to book specifically there.

<img width="1474" alt="Screen Shot 2023-02-01 at 7 42 30 PM" src="https://user-images.githubusercontent.com/109998935/216210622-13d35bf7-1e06-4684-a0e2-856cb6a0fab4.png">

Next, you can see that Airbnbs who had more beds, bedrooms, bathrooms and could accommodate more people had a higher review score over 90. 

<img width="1453" alt="Screen Shot 2023-02-01 at 7 42 43 PM" src="https://user-images.githubusercontent.com/109998935/216210919-87909a50-3766-4b3c-bdf5-85bed857238d.png">

Next, property type vs rating score was shown, and you can see that apartments and houses were the most common property type rented, but that those with a more unique property type scored overwhelmingly positive. This can be further assessed in the future to see if user experience with more unique property types are in demand for that area, or more standard property types such as apartments and houses out of convenience are preferred and what is causing their lower scores overall. 

<img width="1479" alt="Screen Shot 2023-02-01 at 7 42 52 PM" src="https://user-images.githubusercontent.com/109998935/216211751-e203a4b6-2c90-438c-b378-9702b2c816ea.png">

We also checked the relationship between being a Super Host and having the Instant Bookable feature, and that had an impact on the Review Scores Rating. It showed that those who were rated 90 and above, also tended to be Super Hosts and also had the Instant Bookable feature. It can be further assessed to see if customers gravitate more towards instant ease of use, and what are the criteria from airbnb that causes a host to become a super host.

<img width="1475" alt="Screen Shot 2023-02-01 at 7 43 01 PM" src="https://user-images.githubusercontent.com/109998935/216395376-ce38f6ba-ab51-422e-a770-732e378b482f.png">

With the next two visualizations you can see the differences between location based on review score ratings and price for those who scored lowered than 89, and those who scored over 90 in the next visualization. There is a stark difference in the amount of scores between those two score categories, which tells us that there are more positive reviewed scored Airbnbs that is above 90 than less than 89. Price is also filtered by size, and you can see that price is not a determining factor in whether a property will be positively reviewed or not because there were lower cost rentals with a 100 rating, and also ones with the same score but more expensive. It can be further assessed whether price varied by neighborhood, and what type of demographic of people rented the rentals that they chose. 

<img width="1466" alt="Screen Shot 2023-02-01 at 7 43 17 PM" src="https://user-images.githubusercontent.com/109998935/216403312-e27ec72c-d941-43d3-b3f5-ac56dfed54f4.png">

<img width="1474" alt="Screen Shot 2023-02-01 at 7 43 30 PM" src="https://user-images.githubusercontent.com/109998935/216403346-b8fddb4e-205b-4e94-82de-5204284c21b8.png">

Cleaning fees and Extra people were also compared against review rating scores, and it was shown that they had no direct correlation or effect on the review scores. It can be further assessed if consumers see this cost as 'standard' and 'expected.'

<img width="1480" alt="Screen Shot 2023-02-01 at 7 43 42 PM" src="https://user-images.githubusercontent.com/109998935/216410250-4849555b-cb89-4429-a1fd-837ade630215.png">

Lastly, host availability and host acceptance rate was viewed compared against review score ratings to determine an effect or not, and it showed that having availability and the host accepting the Airbnb bookings did have a positive effect on the review score rating, and both graphs are practically identical.  

<img width="1454" alt="Screen Shot 2023-02-01 at 7 43 53 PM" src="https://user-images.githubusercontent.com/109998935/216423771-5d44521d-8266-4eaa-89d8-d43940c65213.png">

What can further be analyzed and discussed can be what determines a host in becoming a super host. We can can see if having more host listings provides an advantage and whether it can be attribute to having more experience, and thus could provide better service, or whether it can be a bad thing and hurt your ratings for not being able to be as attentive with fewer, or one. One can also further look into neighborhoods, and from the neighborhoods that are doing better than others, what are the location and the demographic differences, and what experience is offered there that the other neighborhoods don't offer. Many other assessments were provided throughout this portion of analysis, and it'll not only further answer the question of which factors contribute to a good rating score, but one can further delve into the question of what experience is the consumer looking for from Airbnbs in Seattle. 

## Process & Communication Protocols 

1. Select a data set: see "Source Data" section for data set. 
2. Decide on question to answer: See "Topic" section for our thesis. 
3. Decide which tools to use: Tools used are Python (for the ETL and ML codes), Postgres/AWS, and potentially vislib or a website for the visualization. 
4. Split up work among team for deliverable 1. *Nathan*
   1. Create ERD for soure data & share it with teammates via AWS. This is done and can be visualized by the above ERD. Additionaly the proof of concept code is done to pull data into python from AWS which will be incorporated into the final code. *Blake & Cristal* 
   2. Clean data as necessary and begin to experiment with machine learning models to answer topic question.  See ETL and ML IPYNB codes for ML testing and data clensing. *Blake and Cristal* 
   3. Create README for project.  *Lane*
   4. Decide on a visual and how to incorporate - *TBD*




