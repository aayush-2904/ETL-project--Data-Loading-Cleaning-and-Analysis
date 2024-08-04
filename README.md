**Project Overview**

This project demonstrates a complete data analysis workflow, starting from data loading using the Kaggle API in a Jupyter Python environment, 
followed by data cleaning using pandas, and concluding with data analysis conducted in Microsoft SQL Server (MSSQL).

**Data Loading**

Data is downloaded from Kaggle using the API, ensuring that the dataset is always up-to-date. The Kaggle API+ python+Sql server project.ipynb notebook demonstrates how to authenticate with the Kaggle API and download the dataset.

**Data Cleaning**
The raw data is cleaned using pandas in the data_cleaning.ipynb notebook. The cleaning steps include handling missing values, correcting data types, and removing duplicates. The cleaned data is then send to the MSSQL server using SQLALCHEMY library

**Data Analysis**
The cleaned data is loaded into Microsoft SQL Server, where various SQL queries are used to analyze the data. The SQLQuery1.sql script includes queries for exploratory data analysis (EDA), statistical summaries, and specific business-related questions.
