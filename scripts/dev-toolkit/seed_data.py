"""
Vibe Coding Instant Mock & Seed Data Generator
Quickly generates production-grade, realistic mock data for UI dashboards, APIs and databases.
Usage:
    python seed_data.py <type> [count] [--out <filename.json>] [--db <database.db>]
Types:
    - users       : Full user profiles with avatars, roles, emails, addresses
    - products    : E-commerce items with prices, categories, ratings, stock
    - metrics     : Time-series analytics (daily revenue, active users, signups)
    - posts       : Blog/feed posts with titles, tags, content, authors
"""

import sys
import json
import random
import argparse
from pathlib import Path
from datetime import datetime, timedelta

try:
    from faker import Faker
    fake = Faker("pt_BR")
except ImportError:
    print("Faker not found. Please install with: uv pip install --system faker")
    sys.exit(1)

def generate_users(count: int):
    roles = ["Admin", "Editor", "Cliente", "Desenvolvedor", "Gerente"]
    users = []
    for i in range(1, count + 1):
        users.append({
            "id": i,
            "name": fake.name(),
            "email": fake.email(),
            "phone": fake.phone_number(),
            "role": random.choice(roles),
            "avatar": f"https://api.dicebear.com/7.x/avataaars/svg?seed={fake.user_name()}",
            "city": fake.city(),
            "state": fake.state_abbr(),
            "createdAt": (datetime.now() - timedelta(days=random.randint(1, 365))).isoformat()
        })
    return users

def generate_products(count: int):
    categories = ["Eletrônicos", "Moda", "Acessórios", "Casa & Decoração", "Livros", "Games"]
    products = []
    for i in range(1, count + 1):
        price = round(random.uniform(29.90, 2499.00), 2)
        products.append({
            "id": i,
            "title": fake.catch_phrase(),
            "category": random.choice(categories),
            "price": price,
            "stock": random.randint(0, 150),
            "rating": round(random.uniform(3.5, 5.0), 1),
            "sku": fake.ean13(),
            "status": "Em estoque" if random.random() > 0.1 else "Esgotado"
        })
    return products

def generate_metrics(days: int = 30):
    metrics = []
    base_revenue = 5000.0
    now = datetime.now()
    for i in range(days, 0, -1):
        date = (now - timedelta(days=i)).strftime("%Y-%m-%d")
        revenue = round(base_revenue + random.uniform(-1200, 2800), 2)
        metrics.append({
            "date": date,
            "revenue": revenue,
            "visitors": random.randint(800, 3500),
            "signups": random.randint(20, 140),
            "orders": random.randint(15, 95)
        })
    return metrics

def generate_posts(count: int):
    posts = []
    tags_pool = ["React", "FastAPI", "Tailwind", "Python", "IA", "Design", "DevOps"]
    for i in range(1, count + 1):
        posts.append({
            "id": i,
            "title": fake.sentence(nb_words=6),
            "summary": fake.paragraph(nb_sentences=2),
            "content": fake.text(max_nb_chars=600),
            "author": fake.name(),
            "tags": random.sample(tags_pool, k=random.randint(1, 3)),
            "likes": random.randint(5, 450),
            "publishedAt": (datetime.now() - timedelta(days=random.randint(0, 90))).strftime("%Y-%m-%d")
        })
    return posts

def main():
    parser = argparse.ArgumentParser(description="Instant Mock Data Generator for Vibe Coding")
    parser.add_argument("type", choices=["users", "products", "metrics", "posts"], help="Data model to generate")
    parser.add_argument("count", type=int, nargs="?", default=10, help="Number of records (default: 10)")
    parser.add_argument("--out", type=str, default=None, help="Save to JSON file")
    parser.add_argument("--pretty", action="store_true", default=True, help="Pretty print JSON")
    args = parser.parse_args()

    generators = {
        "users": generate_users,
        "products": generate_products,
        "metrics": generate_metrics,
        "posts": generate_posts
    }

    data = generators[args.type](args.count)

    output_str = json.dumps(data, indent=2 if args.pretty else None, ensure_ascii=False)

    if args.out:
        out_path = Path(args.out)
        out_path.write_text(output_str, encoding="utf-8")
        print(f"[+] Successfully generated {len(data)} {args.type} records saved to: {out_path.resolve()}")
    else:
        print(output_str)

if __name__ == "__main__":
    main()
