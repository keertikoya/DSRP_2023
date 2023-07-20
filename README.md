# Data Science Research Project on Thyroid Disease

#### Background

The purpose of this project is to extract useful information from data on thyroid disease. I also hope to better my R skills and further my data science knowledge. The [thyroid disease dataset](https://www.kaggle.com/datasets/emmanuelfwerr/thyroid-disease-data) used for this project was taken from Kaggle and was "created by reconciling [thyroid disease datasets](https://archive.ics.uci.edu/ml/datasets/thyroid+disease) provided by the UCI Machine Learning Repository." The dataset lists patient demographics and blood test results from a thyroid disease diagnostic.

#### Key Features

1.  **age** - age of the patient **(int)**

2.  **sex** - sex patient identifies **(str)**

3.  **on_thyroxine** - whether patient is on thyroxine **(bool)**

4.  **on antithyroid meds** - whether patient is on antithyroid meds **(bool)**

5.  **sick** - whether patient is sick **(bool)**

6.  **thyroid_surgery** - whether patient has undergone thyroid surgery **(bool)**

7.  **I131_treatment** - whether patient is undergoing I131 treatment **(bool)**

8.  **lithium** - whether patient \* lithium **(bool)**

9.  **tumor** - whether patient has tumor **(bool)**

10. **TSH** - TSH level in blood from lab work **(float)**

11. **T3** - T3 level in blood from lab work **(float)**

12. **TT4** - TT4 level in blood from lab work **(float)**

13. **T4U** - T4U level in blood from lab work **(float)**

14. **FTI** - FTI level in blood from lab work **(float)**

15. **TBG** - TBG level in blood from lab work **(float)**

16. **target** - hyperthyroidism medical diagnosis **(str)**

17. **patient_id** - unique id of the patient **(str)**

#### Results
My final task involved the creation of three regression models (linear, boosted decision tree, and random forest) to predict FTI levels in the blood of a thyroid patient using TSH, T3, TT4, and T4U values as features. My MAE and RMSE values were 5.48 and 11.7 for the linear regression model, 2.81 and 6.94 for the boosted decision tree model, and 2.20 and 5.83 for the random forest model.
