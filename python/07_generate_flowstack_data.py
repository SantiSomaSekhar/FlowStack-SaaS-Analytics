# ==========================================================
# Project : FlowStack SaaS Analytics
# File    : 07_generate_all_tables.py
# Purpose : Generate all synthetic datasets for FlowStack
# Author  : KARNA
# Version : 1.0
# ==========================================================

# ----------------------------
# Import Libraries
# ----------------------------

from faker import Faker
import pandas as pd
import random
import os
from datetime import datetime, timedelta

# ----------------------------
# Initialize Faker
# ----------------------------

fake = Faker()

# Make random generation reproducible
Faker.seed(42)
random.seed(42)

# ----------------------------
# Create Output Folder
# ----------------------------

OUTPUT_FOLDER = "datasets"

os.makedirs(OUTPUT_FOLDER, exist_ok=True)

print("=" * 60)
print("FLOWSTACK DATA GENERATOR")
print("=" * 60)
print("Output Folder :", OUTPUT_FOLDER)
print("=" * 60)

# ==========================================================
# GLOBAL CONFIGURATION
# ==========================================================

NUM_MANAGERS = 20
NUM_CUSTOMERS = 5000

START_DATE = datetime(2023, 1, 1)
END_DATE = datetime(2025, 12, 31)

PLAN_DETAILS = [
    {
        "plan_id": 1,
        "plan_name": "Starter",
        "monthly_price": 29,
        "max_users": 5,
        "storage_limit_gb": 50
    },
    {
        "plan_id": 2,
        "plan_name": "Professional",
        "monthly_price": 79,
        "max_users": 25,
        "storage_limit_gb": 250
    },
    {
        "plan_id": 3,
        "plan_name": "Business",
        "monthly_price": 199,
        "max_users": 100,
        "storage_limit_gb": 1000
    },
    {
        "plan_id": 4,
        "plan_name": "Enterprise",
        "monthly_price": 599,
        "max_users": 500,
        "storage_limit_gb": 5000
    }
]

INDUSTRIES = [
    "SaaS",
    "Finance",
    "Healthcare",
    "Retail",
    "Education",
    "Manufacturing",
    "Marketing",
    "Logistics",
    "Consulting",
    "E-Commerce"
]

REGIONS = [
    "India",
    "USA",
    "Canada",
    "Germany",
    "Australia",
    "Singapore",
    "United Kingdom"
]

ACQUISITION_CHANNELS = [
    "Organic",
    "Referral",
    "Paid Ads",
    "Partner",
    "Outbound Sales",
    "Social Media"
]

PAYMENT_METHODS = [
    "Credit Card",
    "Debit Card",
    "Bank Transfer",
    "UPI"
]

TICKET_CATEGORIES = [
    "Billing",
    "Technical",
    "Feature Request",
    "General"
]

PRIORITIES = [
    "Low",
    "Medium",
    "High",
    "Critical"
]

# ==========================================================
# GENERATE ACCOUNT MANAGERS
# ==========================================================

print("\nGenerating Account Managers...")

account_managers = []

for manager_id in range(1, NUM_MANAGERS + 1):

    account_managers.append({

        "manager_id": manager_id,

        "manager_name": fake.name(),

        "email": fake.company_email(),

        "region": random.choice(REGIONS),

        "experience_years": random.randint(2, 15),

        "created_at": datetime.now()

    })

account_managers_df = pd.DataFrame(account_managers)

account_managers_df.to_csv(
    os.path.join(OUTPUT_FOLDER, "account_managers.csv"),
    index=False
)

print(f"Total Managers Generated : {len(account_managers_df)}")


# ==========================================================
# GENERATE CUSTOMERS
# ==========================================================

print("\nGenerating Customers...")

customers = []

for customer_id in range(1, NUM_CUSTOMERS + 1):

    signup_date = fake.date_between(
        start_date=START_DATE,
        end_date=END_DATE
    )

    customers.append({

        "customer_id": customer_id,

        "company_name": fake.company(),

        "industry": random.choice(INDUSTRIES),

        "region": random.choice(REGIONS),

        "acquisition_channel": random.choice(ACQUISITION_CHANNELS),

        "signup_date": signup_date,

        "manager_id": random.randint(1, NUM_MANAGERS),

        "created_at": datetime.now()

    })

customers_df = pd.DataFrame(customers)

customers_df.to_csv(

    os.path.join(OUTPUT_FOLDER, "customers.csv"),

    index=False

)

print(f"✓ customers.csv generated")

print(f"Total Customers Generated : {len(customers_df)}")
print(customers_df.head())

# ==========================================================
# GENERATE PLANS
# ==========================================================

print("\nGenerating Plans...")

plans = []

for plan in PLAN_DETAILS:

    plans.append({

        "plan_id": plan["plan_id"],

        "plan_name": plan["plan_name"],

        "monthly_price": plan["monthly_price"],

        "max_users": plan["max_users"],

        "storage_limit_gb": plan["storage_limit_gb"],

        "created_at": datetime.now()

    })

plans_df = pd.DataFrame(plans)

plans_df.to_csv(

    os.path.join(OUTPUT_FOLDER, "plans.csv"),

    index=False

)

print("✓ plans.csv generated")

print(f"Total Plans Generated : {len(plans_df)}")

print(plans_df)

# ==========================================================
# GENERATE SUBSCRIPTIONS
# ==========================================================

print("\nGenerating Subscriptions...")

subscriptions = []

subscription_statuses = ["Active", "Cancelled", "Expired"]
status_weights = [82, 10, 8]

billing_cycles = ["Monthly", "Annual"]
billing_weights = [80, 20]

plan_weights = [55, 25, 15, 5]

for customer in customers:

    plan = random.choices(PLAN_DETAILS, weights=plan_weights, k=1)[0]

    start_date = customer["signup_date"]

    status = random.choices(
        subscription_statuses,
        weights=status_weights,
        k=1
    )[0]

    if status == "Active":
        end_date = None
    else:
        end_date = start_date + timedelta(days=random.randint(30, 730))

    subscriptions.append({

        "subscription_id": customer["customer_id"],

        "customer_id": customer["customer_id"],

        "plan_id": plan["plan_id"],

        "billing_cycle": random.choices(
            billing_cycles,
            weights=billing_weights,
            k=1
        )[0],

        "subscription_start": start_date,

        "subscription_end": end_date,

        "subscription_status": status,

        "discount_percent": random.choice([0, 5, 10, 15]),

        "created_at": datetime.now()

    })

subscriptions_df = pd.DataFrame(subscriptions)

subscriptions_df.to_csv(

    os.path.join(OUTPUT_FOLDER, "subscriptions.csv"),

    index=False

)

print("✓ subscriptions.csv generated")

print(f"Total Subscriptions Generated : {len(subscriptions_df)}")

print(subscriptions_df.head())


# ==========================================================
# GENERATE INVOICES
# ==========================================================

print("\nGenerating Invoices...")

invoices = []

invoice_id = 1

for sub in subscriptions:

    start = sub["subscription_start"]

    if sub["billing_cycle"] == "Monthly":
        invoice_count = random.randint(6, 18)
    else:
        invoice_count = random.randint(1, 3)

    plan_price = PLAN_DETAILS[sub["plan_id"] - 1]["monthly_price"]

    discount = sub["discount_percent"]

    final_price = round(plan_price * (1 - discount / 100), 2)

    for i in range(invoice_count):

        if sub["billing_cycle"] == "Monthly":
            invoice_date = start + timedelta(days=30 * i)
            due_date = invoice_date + timedelta(days=7)
        else:
            invoice_date = start + timedelta(days=365 * i)
            due_date = invoice_date + timedelta(days=15)

        payment_status = random.choices(
            ["Paid", "Pending", "Failed"],
            weights=[90, 8, 2],
            k=1
        )[0]

        if payment_status == "Paid":
            paid_date = due_date - timedelta(days=random.randint(0, 5))
        else:
            paid_date = None

        invoices.append({

            "invoice_id": invoice_id,

            "subscription_id": sub["subscription_id"],

            "invoice_date": invoice_date,

            "due_date": due_date,

            "paid_date": paid_date,

            "amount": final_price,

            "payment_method": random.choice([
                "Credit Card",
                "Debit Card",
                "Bank Transfer",
                "UPI"
            ]),

            "payment_status": payment_status,

            "created_at": datetime.now()

        })

        invoice_id += 1

invoices_df = pd.DataFrame(invoices)

invoices_df.to_csv(

    os.path.join(OUTPUT_FOLDER, "invoices.csv"),

    index=False

)

print("✓ invoices.csv generated")

print(f"Total Invoices Generated : {len(invoices_df)}")

print(invoices_df.head())


# ==========================================================
# GENERATE SUPPORT TICKETS
# ==========================================================

print("\nGenerating Support Tickets...")

support_tickets = []

ticket_id = 1

for customer in customers:

    # Each customer creates 0–5 tickets
    ticket_count = random.randint(0, 5)

    for _ in range(ticket_count):

        created_date = customer["signup_date"] + timedelta(
            days=random.randint(0, 700)
        )

        status = random.choices(
            ["Open", "In Progress", "Resolved", "Closed"],
            weights=[10, 10, 30, 50],
            k=1
        )[0]

        if status in ["Resolved", "Closed"]:
            resolved_date = created_date + timedelta(
                days=random.randint(1, 10)
            )
            resolution_hours = random.randint(2, 72)
        else:
            resolved_date = None
            resolution_hours = None

        support_tickets.append({

            "ticket_id": ticket_id,

            "customer_id": customer["customer_id"],

            "category": random.choice([
                "Technical",
                "Billing",
                "Feature Request",
                "General"
            ]),

            "priority": random.choices(
                ["Low", "Medium", "High", "Critical"],
                weights=[35, 40, 20, 5],
                k=1
            )[0],

            "status": status,

            "ticket_created_date": created_date,

            "ticket_resolved_date": resolved_date,

            "resolution_hours": resolution_hours,

            "customer_rating": round(random.uniform(3.0, 5.0), 1),

            "created_at": datetime.now()

        })

        ticket_id += 1

support_df = pd.DataFrame(support_tickets)

support_df.to_csv(

    os.path.join(OUTPUT_FOLDER, "support_tickets.csv"),

    index=False

)

print("✓ support_tickets.csv generated")

print(f"Total Tickets Generated : {len(support_df)}")

print(support_df.head())


# ==========================================================
# GENERATE USAGE LOGS
# ==========================================================

print("\nGenerating Usage Logs...")

usage_logs = []

usage_id = 1

for sub in subscriptions:

    plan = PLAN_DETAILS[sub["plan_id"] - 1]

    if plan["plan_name"] == "Starter":
        months = random.randint(3, 8)
        api_range = (500, 5000)
        storage_range = (5, 40)

    elif plan["plan_name"] == "Professional":
        months = random.randint(6, 12)
        api_range = (5000, 30000)
        storage_range = (40, 200)

    elif plan["plan_name"] == "Business":
        months = random.randint(8, 18)
        api_range = (30000, 150000)
        storage_range = (200, 900)

    else:
        months = random.randint(12, 24)
        api_range = (150000, 500000)
        storage_range = (900, 4500)

    for month in range(months):

        usage_month = sub["subscription_start"] + timedelta(days=30 * month)

        usage_logs.append({

            "usage_id": usage_id,

            "customer_id": sub["customer_id"],

            "usage_month": usage_month,

            "active_users": random.randint(
                1,
                plan["max_users"]
            ),

            "api_requests": random.randint(
                api_range[0],
                api_range[1]
            ),

            "storage_used_gb": round(
                random.uniform(
                    storage_range[0],
                    storage_range[1]
                ),
                2
            ),

            "login_count": random.randint(10, 500),

            "created_at": datetime.now()

        })

        usage_id += 1

usage_df = pd.DataFrame(usage_logs)

usage_df.to_csv(

    os.path.join(
        OUTPUT_FOLDER,
        "usage_logs.csv"
    ),

    index=False

)

print("✓ usage_logs.csv generated")

print(f"Total Usage Records Generated : {len(usage_df)}")

print(usage_df.head())

# ==========================================================
# GENERATE MONTHLY TARGETS
# ==========================================================

print("\nGenerating Monthly Targets...")

monthly_targets = []

target_id = 1

months = pd.date_range(
    start="2024-01-01",
    end="2026-12-01",
    freq="MS"
)

for manager in account_managers:

    for month in months:

        target = random.randint(80000, 300000)

        achieved = round(
            target * random.uniform(0.75, 1.20),
            2
        )

        monthly_targets.append({

            "target_id": target_id,

            "manager_id": manager["manager_id"],

            "target_month": month.date(),

            "target_revenue": target,

            "achieved_revenue": achieved,

            "created_at": datetime.now()

        })

        target_id += 1

monthly_targets_df = pd.DataFrame(monthly_targets)

monthly_targets_df.to_csv(

    os.path.join(
        OUTPUT_FOLDER,
        "monthly_targets.csv"
    ),

    index=False

)

print("✓ monthly_targets.csv generated")

print(f"Total Monthly Targets : {len(monthly_targets_df)}")

print(monthly_targets_df.head())
