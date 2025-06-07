# 📊 Global Superstore – Sales & Customer Insights (SQL Project)

A data analysis project using **MySQL** and **Excel** based on the Global Superstore dataset. The goal is to extract business insights from raw retail data by writing SQL queries on structured tables like Customers, Products, and Orders.

---

## ✅ Project Summary

- 📦 **Data Collection**: Downloaded the dataset from Kaggle (Global Superstore).
- 🧹 **Data Cleaning**: Cleaned raw Excel data — standardized date formats and split it into three CSV files: `Customers`, `Orders`, and `Products`.
- 🧮 **Data Import**: Imported CSV files into MySQL using **MySQL Workbench's Data Import Wizard**.
- 🧾 **Query Writing**: Wrote multiple SQL queries to analyze:
  - Sales by region and segment
  - Top customers and products
  - Discount impact on profit
  - Time-based trends (sales, shipping delays)
- 📂 **Results Exported**: Saved output of queries as `.csv` files and added them to GitHub for transparency and analysis sharing.

---

## 📂 Project Structure

<pre>```text
superstore-sql-analysis/
├── data/
│ ├── raw/ # Original CSVs (Orders, Customers, Products)
│ └── processed/ # Query results exported as CSV files
├── queries/ # SQL files containing analysis queries
├── README.md 
```</pre>

---

## 🛠️ Tools Used

- **Excel** – For initial data cleaning and formatting
- **MySQL Workbench** – For importing, managing schema, and running SQL queries
- **SQL** – Core tool for querying and data analysis
- **GitHub** – Version control and project sharing

---

## 📊 SQL Analysis Highlights

- ✅ Number of customers and sales by segment
- ✅ Profit and sales by region and category
- ✅ Top-performing customers and products
- ✅ Loss-making sub-categories due to discounts
- ✅ Monthly trends in sales and shipping

> All query outputs are available in the `Results/` folder.

---

## 🧠 Insights Gained

- Eastern Region has the maximum profit margins and least average shipping time, while the southern region is worst on both these metrics.
- Discounts beyond 20% in the 'Furniture' category consistently lead to net losses.
- Best performing products are in the office supplies and technology category.

## 🔮 Future Work

- 📈 **Excel Dashboard**: Use the SQL output to build an interactive Excel dashboard with KPIs and charts.
- 📊 **Power BI** version of the dashboard for better interactivity.
- 📑 Write blog post or case study to explain findings and visualizations.

---

## 📁 Data Source

- [Global Superstore Dataset on Kaggle](https://www.kaggle.com/datasets)

---

## 🙋‍♂️ About Me

This project is part of my **Data Analyst portfolio**, showcasing my ability to:
- Clean and structure data for analysis
- Write and optimize SQL queries for business insights
- Use real-world datasets to simulate analyst workflows
