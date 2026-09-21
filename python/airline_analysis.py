import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="ArizooRayyan",
    database="airline_analytics"
)

print("MySQL connection successful!")

# query = """
# SELECT
#     Month,
#     COUNT(*) AS total_flights,
#     SUM(ArrDel15) AS delayed_flights,
#     ROUND(SUM(ArrDel15) * 100.0 / COUNT(*), 2) AS delay_rate
# FROM flights
# WHERE Cancelled = 0
# GROUP BY Month
# ORDER BY Month;
# """

# df = pd.read_sql(query, conn)

# print("\nMonthly Delay Rate:")
# print(df.to_string(index=False))

# plt.figure(figsize=(10, 6))

# plt.plot(
#     df["Month"],
#     df["delay_rate"],
#     marker="o"
# )

# plt.title("Monthly Flight Delay Rate - 2025")
# plt.xlabel("Month")
# plt.ylabel("Delay Rate (%)")
# plt.xticks(range(1, 13))
# plt.grid(True)

# plt.tight_layout()
# plt.show()




# ==========================================
# STEP 6 - AIRLINE ON-TIME PERFORMANCE
# ==========================================

# query = """
# SELECT
#     Reporting_Airline,
#     COUNT(*) AS total_flights,
#     SUM(ArrDel15) AS delayed_flights,
#     SUM(CASE WHEN ArrDel15 = 0 THEN 1 ELSE 0 END) AS on_time_flights,
#     ROUND(
#         SUM(CASE WHEN ArrDel15 = 0 THEN 1 ELSE 0 END) * 100.0
#         / COUNT(*), 2
#     ) AS on_time_rate
# FROM flights
# WHERE Cancelled = 0
# GROUP BY Reporting_Airline
# ORDER BY on_time_rate DESC;
# """

# df = pd.read_sql(query, conn)

# print("\nAirline On-Time Performance:")
# print(df.to_string(index=False))

# plt.figure(figsize=(12, 6))
# plt.bar(df["Reporting_Airline"], df["on_time_rate"])

# plt.title("Airline On-Time Performance - 2025")
# plt.xlabel("Airline")
# plt.ylabel("On-Time Rate (%)")
# plt.xticks(rotation=45)
# plt.grid(axis="y")
# plt.tight_layout()
# plt.show()

# ==========================================
# STEP 7 - AVERAGE ARRIVAL DELAY BY AIRLINE
# ==========================================

# query = """
# SELECT
#     Reporting_Airline,
#     COUNT(*) AS delayed_flights,
#     ROUND(AVG(ArrDelay), 2) AS avg_arrival_delay
# FROM flights
# WHERE Cancelled = 0
#   AND ArrDelay > 0
# GROUP BY Reporting_Airline
# ORDER BY avg_arrival_delay DESC;
# """

# df = pd.read_sql(query, conn)

# print("\nAverage Arrival Delay by Airline:")
# print(df.to_string(index=False))

# plt.figure(figsize=(12, 6))
# plt.bar(df["Reporting_Airline"], df["avg_arrival_delay"])

# plt.title("Average Arrival Delay by Airline - 2025")
# plt.xlabel("Airline")
# plt.ylabel("Average Arrival Delay (Minutes)")
# plt.xticks(rotation=45)
# plt.grid(axis="y")
# plt.tight_layout()
# plt.show()


# ==========================================
# STEP 8 - TOP 10 BUSIEST ORIGIN AIRPORTS
# ==========================================

query = """
SELECT
    Origin,
    COUNT(*) AS total_flights
FROM flights
GROUP BY Origin
ORDER BY total_flights DESC
LIMIT 10;
"""

df = pd.read_sql(query, conn)

print("\nTop 10 Busiest Origin Airports:")
print(df.to_string(index=False))

plt.figure(figsize=(12, 6))
plt.bar(df["Origin"], df["total_flights"])

plt.title("Top 10 Busiest Origin Airports - 2025")
plt.xlabel("Airport")
plt.ylabel("Number of Flights")
plt.xticks(rotation=45)
plt.grid(axis="y")
plt.tight_layout()
plt.show()


conn.close()

print("\nMySQL connection closed.")